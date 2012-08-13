# DateParity

Consistent date formatting and parsing for Rails applications. Creates parity between date.to\_s and
 string.to\_date in Rails applications.

This is implemented with a "Date.format" syntax and usage, similar to "Time.zone" in rails. This can be 
set per request (i.e. per user) in a controller before or around filter.

## Installation

Add this line to your application's Gemfile:

    gem 'date_parity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_parity

## Usage

In Rails controller before\_filter:
Date.format = '%m/%d/%Y'

or from a persisted field that stores the desired format:
Date.format = current\_user.date\_format 

In any view assuming @model\_created\_on is a date, and Date.format
was set as above:
<%=@modele.created\_on  %>
=> 12/31/2012 

And then you get parity when a form with this field is posted. 
Rails will attempt to convert the posted string value of "12/31/2012"
using Date.\_parse, which DateParity overrides and respects your Date.format. 
Without DateParity gem, @model.start\_on would have ended up nil because 
"12/31/2012" is invalid argument Ruby Date.\_parse. However, when date\_parity is 
included, Date will use the format string stored on Date.format
(if it exist) to correctly parse "12/31/2012", as December 31, 2012, when 
Date.format = "%m/%d/%Y" 

Note: Rails text\_field form helper uses @model.attribute\before\_type\_cast by default.
When using date\_parity on plain text fields, you will probably want to set your value
to explicitly use @model.attribute if it exists. Otherwise, you won't see the formatted
date field:
For example:
<%= f.text_field :created_on, :value => @user.created\_on ||  @user.created\_on\_before\_type\_cast %>

Date.format can be set to any date format that is parsable by strptime. 
For example, the following are all valid:
    Date.format = "%m/%d/%Y"
    Date.format = "%d/%m/%Y"
    Date.format = '%Y-%m-%d'
    Date.format = '%d.%m.%Y'
    Date.format = '%Y.%m.%d'
    Date.format = '%Y/%m/%d'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

