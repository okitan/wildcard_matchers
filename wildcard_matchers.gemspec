# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["okitan"]
  gem.email         = ["okitakunio@gmail.com"]
  gem.description   = "wildcard matchers"
  gem.summary       = "wildcard matchers which can use in rspec"
  gem.homepage      = "https://github.com/okitan/wildcard_matchers"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wildcard_matchers"
  gem.require_paths = ["lib"]

  gem.license = 'MIT'

  gem.version       = File.read(File.join(File.dirname(__FILE__), "VERSION")).chomp

  gem.add_dependency "facets"
  gem.add_dependency "addressable", "~> 2.3"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "autowatchr"

  # for debug
  gem.add_development_dependency "pry"
  gem.add_development_dependency "tapp"

  # ci
  gem.add_development_dependency "coveralls"
end
