# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["okitan"]
  gem.email         = ["okitakunio@gmail.com"]
  gem.description   = "ambiguous matching enabled"
  gem.summary       = "ambiguous matching enabled"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wildcard_matchers"
  gem.require_paths = ["lib"]

  gem.version       = File.read(File.join(File.dirname(__FILE__), "VERSION")).chomp

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "autowatchr"

  # for debug
  gem.add_development_dependency "pry"
end
