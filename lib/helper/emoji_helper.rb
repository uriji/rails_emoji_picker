require_relative './emoji_regex'

# UrijiEmojiPicker
module UrijiEmojiPicker
  def content_with_emoji(text)
    find_emoji(text)
  end

  private

  def find_emoji(text)
    string  = replace_unicode_moji_with_images(text) || text
    emoji   = string.scan(regex)
    unicodes = []
    index = UrijiEmojiPicker::EmojiMap.new

    emoji.each do |e|
      next if e.empty?
      tmp_emoji = e.join('')
      moji = index.find_by_moji(tmp_emoji)

      if moji
        flags = exceptions_emoji(tmp_emoji)
        if flags.empty?
          name = moji[0] if moji[0]
          char = moji[1]['char'] if moji[1]['char']
          hash_emoji = { name: name, char: char }
        else
          hash_emoji = flags
        end
      else
        hash_emoji = exceptions_emoji(tmp_emoji)
      end

      unicodes << hash_emoji
    end

    unicodes.each do |hash|
      next if hash.nil?
      hash.reject! { |i| i.nil? }

      insert_image_to_image_tag(string, hash) if hash[:char]
    end

    string.respond_to?(:html_safe) ? string.html_safe : string
  end

  def replace_unicode_moji_with_images(string)
    index = UrijiEmojiPicker::EmojiMap.new

    string.gsub!(regex) do |moji|
      if moji.size < 2 && index.find_by_moji(moji)
        alt = index.find_by_moji(moji)[0]
      else
        tmp = exceptions_emoji(moji)
        alt = tmp[:name] if tmp.key?(:name)
      end

      %(<span class='emoji-image'><img alt='#{alt}' class="emoji" src="#{moji}"></span>)
    end
  end

  def insert_image_to_image_tag(string, img)
    stanadrt_replace(string, img)
  end

  def stanadrt_replace(string, img)
    string.gsub!(img[:char], "#{Emoji.asset_host}#{Emoji.asset_path}/#{img[:name]}.png")
  end

  def regex
    UrijiEmojiPicker::EmojiRegex.regex
  end

  def emoji_map
    UrijiEmojiPicker::EmojiMap
  end

  def exceptions_emoji(emoji)
    UrijiEmojiPicker::EmojiExceptions.call(emoji)
  end
end
