require 'date'
require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/string/conversions'

require "date_parity/version"
require 'date_parity/core_ext/string'
require 'date_parity/core_ext/date'

# ActiveSupport provides an implementation of Date.to_s that uses
# Date::DATE_FORMATS[:default] to format date the string by default.
# We create a default DATE_FORMAT here that uses a proc that respects 
# our custom Date.format value, which can be set per thread.
Date::DATE_FORMATS[:default] = lambda { |date| date.strftime(Date.format)}


