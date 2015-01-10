$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "autoload_path/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "autoload_path"
  s.version     = AutoloadPath::VERSION
  s.authors     = ["Emilio Forrer"]
  s.email       = ["dev.emilio.forrer@gmail.com"]
  s.homepage    = "https://github.com/emilioforrer/autoload_path"
  s.summary     = " A library to auto require files in path"
  s.description = " autoload_path it’s a very simple gem that allows you to search through a folder and it’s subfolders in search of files and automatically require them."
  s.license     = "MIT"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = Dir["LICENSE", "Rakefile", "README.md"]
  s.files += Dir['lib/**/*.rb']
  s.test_files = Dir["test/**/*"]
  s.post_install_message = "Thanks for installing autoload_path! ^_^"

 
end
