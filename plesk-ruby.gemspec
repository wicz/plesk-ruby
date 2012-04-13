# -*- encoding: utf-8 -*-
require File.expand_path('../lib/plesk-ruby/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vinicius Horewicz"]
  gem.email         = ["vinicius@horewi.cz"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  gem.name          = "plesk-ruby"
  gem.require_paths = ["lib"]
  gem.version       = Plesk::Ruby::VERSION

  gem.add_development_dependency "rspec",   "~> 2.9.0"
  gem.add_development_dependency "webmock", "~> 1.8.6"
end
