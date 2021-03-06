lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uriji_emoji_picker/version'

Gem::Specification.new do |spec|
  spec.name          = 'uriji_emoji_picker'
  spec.version       = UrijiEmojiPicker::VERSION
  spec.authors       = ['Carlos Serrada']
  spec.email         = ['cserradag96@gmail.com']

  spec.summary       = 'Simple Emoji picker for your app'
  spec.description   = 'Simple Emoji picker for your app'
  spec.homepage      = 'https://github.com/uriji/uriji-emoji-picker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'emoji'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'
end
