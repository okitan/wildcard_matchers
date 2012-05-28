require "rspec"
require "wildcard_matchers"

RSpec.configure do |c|
  c.include WildcardMatchers
end

RSpec::Matchers.define :wildcard_match do |expected|
  match do |actual|
    WildcardMatchers.wildcard_match?(actual, expected)
  end

  failure_message_for_should do |actual|
    failures = [ default_failure_message_for_should ]
    on_failure = proc {|message| failures << message }

    WildcardMatchers.wildcard_match?(actual, expected, &on_failure)

    failures.join("\n")
  end
end
