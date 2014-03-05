# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'altergeo_api/version'

Gem::Specification.new do |gem|
  gem.name          = "altergeo_api"
  gem.version       = AltergeoApi::VERSION
  gem.authors       = ["Eugene Jeks"]
  gem.email         = ["ya.jeks@yandex.ru"]
  gem.description   = ''
  gem.summary       = ''
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware', '~> 0.9'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'addressable'
end

