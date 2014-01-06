# -*- encoding: utf-8 -*-
require File.expand_path('../lib/date_parity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "date_parity"
  gem.version       = DateParity::VERSION

  gem.author       = 'Scott Stewart'
  gem.email         = 'scott@scopestar.com'
  gem.description   = 'Rails Date formatting and parsing per request via Date.format.'
  gem.summary       = 'Simple Date formatting for Rails applications that provides full parity between date.to_s.and string.to_date per request. Automatically parse dates to and from your db with custom formats set per page request in a similar fashion to Time.zone settings.'
  gem.homepage      = "https://github.com/scott-stewart/date_parity"
  gem.license  = 'MIT'

  gem.add_runtime_dependency 'activesupport', '~> 4.0', '>= 4.0.0'

  gem.add_development_dependency 'rake' 
  gem.add_development_dependency 'minitest'

  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.files = `git ls-files`.split($\)
end
