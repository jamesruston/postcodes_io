# PostcodesIo

A simple wrapper around [postcodes.io](http://postcodes.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postcodes_io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postcodes_io

## Usage

Require the gem

```ruby
require 'PostcodesIO'
```

Lookup a postcode

```ruby
result = PostcodesIO::lookup('NN12 8TN')
puts result.longitude #
puts result.latitude #
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/postcodes_io/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
