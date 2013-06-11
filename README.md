# AltergeoApi

Ruby client for altergeo openapi/v1

## Installation

Add this line to your application's Gemfile:

    gem 'altergeo_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install altergeo_api

## Usage

### Not authenticated requests

```ruby
places = AltergeoApi.places :query => 'bank'
```

### Authenticated requests
```ruby
client = AltergeoApi::Client.new :email => 'some@example.com'
                                 :password => 'somepassword'
places = client.places :query => 'bank'
client.checkin!(:place_id => places.first.id)
```

### WillPaginate for places collection

```paginate``` method not included to ResourceCollection by default.
Use ```AltergeoApi.enable_will_paginate!``` to add pagination.

places = client.places :query => 'bank'
places.paginate(:page => params[:page], :per_page => params[:per])
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
