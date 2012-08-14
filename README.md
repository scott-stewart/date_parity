# Date Parity

Date formatting and parsing per request in Rails with parity between date.to\_s.and string.to\_date.

Rails already has some great Date formatting and parsing options available. For example, Date.DATE\_FORMATS makes it easy to configure and reuse common formats for your application. But, other then the :default it require an explicit field.to\_s(:format) to be applied. Additionally, nothing happens automatically when parsing those dates back from user edits. This generally require some explicit steps per field in your model or controller. 

Rails also provides the ability to localize your Date formats. But, that requires decisions made for all users in a particular locale.

Often, we need to allow users, companies, organizations, etc. the ability to choose preferred date formats. Both of the Rails standard approaches using Date.DATE\_FORMATS or localization fall short at making that easy. You end up writing a lot helpers around date fields, and code to normalize posted date values. 
 
This is where date\_parity helps. It is implemented by setting a `Date.format` string, similar to a per user `Time.zone` in Rails. This can be set per request (i.e. per user) in a controller's before\_filter or around\_filter.

For example:
```ruby
Date.format = "%m/%d/%Y"
date = "12/31/2012".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "12/31/2012"

Date.format = "%d/%m/%Y"
date = "31/12/2012".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "31/12/2012"

Date.format = '%Y-%m-%d'
date = "2012-12-31".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "2012-12-31"

Date.format = '%d.%m.%Y'
date = "31.12.2012".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "31.12.2012"

Date.format = '%Y.%m.%d'
date = "2012.12.31".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "2012.12.31"

Date.format = '%Y/%m/%d'
date = "2012/12/31".to_date
=> Mon, 31 Dec 2012
date.to_s
=> "2012/12/31"
```

## Installation

Add this line to your application's Gemfile:

    gem 'date_parity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_parity

## Usage

In a Rails controller before\_filter:
```Date.format = '%m/%d/%Y'```

Generally, you will want to set that string based on user preference, as in:
```Date.format = current_user.date_format```

Then in any view assuming @model\_started\_on is a date field, and Date.format was set as above to '%m/%d/%Y':
```ruby
<%=@modele.started_on  %>
#=> '12/31/2012' 
```

And then you get parity when a form with this field is posted. Rails will attempt to convert the posted string value of "12/31/2012" using Date.\_parse, which DateParity overrides and respects your Date.format.  

Without the date\_parity gem, @model.start\_on would have ended up nil because "12/31/2012" is an invalid argument for ruby Date.\_parse. However, when date\_parity is included, Date will use the format string set on Date.format to correctly parse "12/31/2012", as December 31, 2012, when Date.format = "%m/%d/%Y". 

Note: Rails text\_field form helper uses ```@model.attribute_before_type_cast``` by default.  When using date\_parity on plain text fields, you will probably want to set your value to explicitly use @model.attribute if it exists. Otherwise, you won't see the formatted date field: For example:
```ruby 
<%= f.text_field :start_on, :value => @user.started_on ||  @user.started_on_before_type_cast %>
```

Date.format can be set to any date format that can be parsed by strptime. 
For example, the following are all valid:
```ruby
Date.format = "%m/%d/%Y"
Date.format = "%d/%m/%Y"
Date.format = '%Y-%m-%d'
Date.format = '%d.%m.%Y'
Date.format = '%Y.%m.%d'
Date.format = '%Y/%m/%d'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

