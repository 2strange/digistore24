# Digistore24
[![Build Status](https://travis-ci.org/henvo/digistore24.svg?branch=master)](https://travis-ci.org/henvo/digistore24)

Digistore24 IPN integration library for rails and other web applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'digistore24'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digistore24

## Usage

TODO: Write usage instructions here

## Configuration

You can configure this gem by running:

``` ruby
Digistore24.configure |config|
  config.passphrase = 'xxxxx'
end
```

You can define any key here. But you have to provide at least:

* `passphrase` The IPN passphrase

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/henvo/digistore24.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
