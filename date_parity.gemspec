# -*- encoding: utf-8 -*-
require File.expand_path('../lib/date_parity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "date_parity"
  gem.version       = DateParity::VERSION

  gem.author       = 'Scott Stewart'
  gem.email         = 'scottpstewart@gamil.com'
  gem.description   = 'Consistent date formatting done simple'
  gem.summary       = 'Consistent date formatting done simple'
  gem.homepage      = ""

  gem.add_dependency 'activesupport', '>= 3.2'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.files = `git ls-files`.split($\)
end
