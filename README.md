# DateParity

Consistent date formatting per request; creating parity between date.to\_s and
 string.to\_date.

Provides a Date.format syntax and usage, similiar to Time.zone in rails. Can be 
set per request (i.e. per user).

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
or
Date.format = current\_user.date\_format 

In any view assuming @resourc\_created\_on is a date::
@resource.start\_on  
will render: 12/31/2012 

And then you get parity when a form with this field is posted. 
Rails will attempt to convert the posted string value of "12/31/2012"
using "12/31/2012".to\_date in the respective model before validation. 
Under normal circumstances, @resource.start\_on will end up being nil 
because "12/31/2012".to\_date is invalid for Ruby Date.\_parse. 

When date\_parity is required, Date will use the format string stored on Date.formt
to correctly parse "12/31/2012". This is accomplished by overriding String.to\_date 
to use : Date.strptime(self, Date.format).to\_s(:db)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

