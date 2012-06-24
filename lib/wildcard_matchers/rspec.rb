require "rspec"
require "wildcard_matchers"

RSpec.configure do |c|
  c.include WildcardMatchers
end

RSpec::Matchers.define :wildcard_match do |expected|
  match do |actual|
    @matcher = WildcardMatchers::WildcardMatcher.new(expected)
    @matcher === actual
  end

  failure_message_for_should do |actual|
    @matcher.errors.join("\n")
  end
end
