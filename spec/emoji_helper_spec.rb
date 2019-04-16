require 'spec_helper'

describe UrijiEmojiPicker do
  helper = Class.new.extend(UrijiEmojiPicker)

  describe '#emojify' do
    correct_emoji_format = helper.emojify("⚽️ Soccer emoji")

    it 'return correct image src with emoji' do
      expect(correct_emoji_format).to eq "<span class='emoji-image'><img alt='soccer' class=\"emoji\" src=\"#{Emoji.asset_host}#{Emoji.asset_path}/soccer.png\"></span> Soccer emoji"
    end
  end

  describe 'custom asset_host and asset_path' do
    it 'return img src tag with custom host and path' do
      Emoji.asset_host = 'https://mysite.com/'
      Emoji.asset_path = '/images/emoji/'
      string = helper.emojify('Test String 🐱')

      expect(string).to eq "Test String <span class='emoji-image'><img alt='cat' class=\"emoji\" src=\"https://mysite.com/images/emoji//cat.png\"></span>"
    end
  end
end
