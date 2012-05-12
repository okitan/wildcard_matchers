# wildcard_matchers [![Build Status](https://secure.travis-ci.org/okitan/wildcard_matchers.png?branch=master)](http://travis-ci.org/okitan/wildcard_matchers)

## General Usage

```ruby
require "wildcard_matchers"

WildcardMatchers.wild_card_match("string", /str/) #=> true

require "wildcard_matchers/rspec"

describe "wildcard_matcher" do
  it "should wildcard match" do
    { :a => [ "hoge", "fuga" ] }.should wildcard_match(:a => [ is_a_string, /^fu/ ])
  end
end
```

See specs, for more detail.

### wildcard matchers
* is_a(class)
 * is_a(String) === String #=> true
 * is_a_string === String #=> true
* is_bool
 * is_bool === true  #=> true
 * is_bool === false #=> true
 * is_bool === object #=> false
* is_time
 * is_time === "2012-05-13" #=> true
* hash_includes
 * hash_includes(:a) === { :a => 1 } #=> true
 * hash_includes(:b) === { :a => 1 } #=> false
 * hash_includes(:a => Integer) === { :a => 1 } #=> true
 * hash_includes(:a => 2) === { :a => 1 } #=> false

## How it works

It is very simple. Recursive match using ===, and Class, Range, and Proc act as wildcard matchers.

You can create original matcher using lambda.

```ruby
original_matcher = lamda do |actual|
  (…as you like…)
end

wildcard_matcher?("actual", original_matcher)
```

## Installation

Add this line to your application's Gemfile:

    gem 'wildcard_matchers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wildcard_matchers

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
