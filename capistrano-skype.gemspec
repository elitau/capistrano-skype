# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/skype/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-skype"
  spec.version       = Capistrano::Skype::VERSION
  spec.authors       = ["Eduard Litau"]
  spec.email         = ["eduard.litau@gmail.com"]
  spec.summary       = %q{Capistrano 3 tasks to notify deployments via skype.}
  spec.description   = "Theses recipies allow to send deploy notifications to "\
                        "a named skype chat"
  spec.homepage      = "https://github.com/elitau/capistrano-skype"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "capistrano", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake",    "~> 10.0"
end
