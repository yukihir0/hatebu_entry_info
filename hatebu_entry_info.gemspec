# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hatebu_entry_info/version'

Gem::Specification.new do |gem|
  gem.name          = "hatebu_entry_info"
  gem.version       = HatebuEntryInfo::VERSION
  gem.authors       = ["yukihir0"]
  gem.email         = ["yukihiro.cotori@gmail.com"]
  gem.description   = %q{'hatebu_entry_info' is ruby library for 'hatena bookmark entry information get API'.}
  gem.summary       = %q{'hatebu_entry_info' is ruby library for 'hatena bookmark entry information get API'.}
  gem.homepage      = "https://github.com/yukihir0/hatebu_entry_info"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "json", "~>1.8.3"
  gem.add_development_dependency "rake", "~>10.4.2"
  gem.add_development_dependency "rspec", "~>3.3.0"
  gem.add_development_dependency "coveralls", "~>0.8.2"
end
