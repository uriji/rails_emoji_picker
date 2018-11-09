module UrijiEmojiPicker
  class Engine < Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer 'initialize uriji_emoji_picker helper' do |_app|
      ActiveSupport.on_load(:action_view) do
        include UrijiEmojiPicker
      end
    end
  end
end
