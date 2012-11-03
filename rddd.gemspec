# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rddd/version'

Gem::Specification.new do |gem|
  gem.name          = "rddd"
  gem.version       = Rddd::VERSION
  gem.authors       = ["Petr Janda"]
  gem.email         = ["petrjanda@me.com"]
  gem.description   = %q{Ruby DDD framework}
  gem.summary       = %q{Intention of rddd is to provide basic skeleton for DDD ruby application. Its framework agnostic, although some framework specific extensions might come later to make it easier to start.}
  gem.homepage      = "blog.ngneers.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
