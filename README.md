# OmniSeeds

Provides omnipotent seeds for rails.

Enhances the standard rails seeds and the rake tasks with helper methods to
enable omnipotent and easier maintenance of seeds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omni_seeds'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omni_seeds

## Usage

You can use the helper methods directly in your `seeds.rb`.

* `seed(model, find_or_create_by, update_with = {})`
* `seed_file(name)`

Example:

```ruby
seed User, { email: 'job@bluth.com' }, {
  first_name: 'Gob',
  last_name: 'Bluth',
  avatar: seed_file('gob.jpg')
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/panter/omni_seeds.
