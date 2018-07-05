[![Gem Version](https://badge.fury.io/rb/seed_box.svg)](https://badge.fury.io/rb/seed_box)
[![Build Status](https://travis-ci.org/panter/seed_box.svg?branch=master)](https://travis-ci.org/panter/seed_box)
[![Maintainability](https://api.codeclimate.com/v1/badges/d5ab1518113fb181b470/maintainability)](https://codeclimate.com/github/panter/seed_box/maintainability)

# SeedBox

Provides omnipotent seeds for rails.

Enhances the standard rails seeds and the rake tasks with helper methods to
enable omnipotent and easier maintenance of seeds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seed_box'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install seed_box

## Usage

### Seed helpers

You can use the helper methods directly in your `seeds.rb`.

* `seed(model, find_or_create_by, update_with = {})`


  Finds the `model` record by the attributes provided by `find_or_create_by` or
  creates a new record if it doesn't exist yet. The attributes provided by
  `update_with` are updated in any case.

* `seed_once(model, find_or_create_by, create_with = {})`


  Finds the `model` record by the attributes provided by `find_or_create_by` or
  creates a new record if it doesn't exist yet. The attributes provided by
  `create_with` are only applied the first time, when the record gets created.

* `seed_file(name)`


  Seeds a file, whereas the `name` is the file name. The path root is
  `Rails.root.join('db/seeds')`.

Example:

```ruby
seed User, { email: 'job@bluth.com' }, {
  first_name: 'Gob',
  last_name: 'Bluth',
  avatar: seed_file('gob.jpg')
}
```

### Development / Production seeds

This gem also provides a separation between development and production seeds. Usually the production seeds are a subset of the development seeds.

Additionally to the standard rails rake task `db:seed` there is
`db:seed:production` which loads the seeds from the file
`db/seeds.production.rb` if it exists.

The rake task `db:seed` loads the seeds from `db/seeds.production.rb` if it
exists as well.

The following list summarizes the different seeds:

* `rake db:seed`


  loads `db/seeds.production.rb` (if it exists) and
  `db/seeds.rb`

* `rake db:seed:production`


   loads `db/seeds.production.rb` (if it exists)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/panter/seed_box.
