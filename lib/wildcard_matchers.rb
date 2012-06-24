module WildcardMatchers
  autoload :Helpers,  "wildcard_matchers/helpers"
  autoload :Matchers, "wildcard_matchers/matchers"
  autoload :WildcardMatcher, "wildcard_matchers/wildcard_matcher"

  include Helpers
  include Matchers

  def wildcard_match?(actual, expected, &on_failure)
    errors = WildcardMatcher.check_errors(actual, expected)

    if errors.empty? #matcher.errors.empty?
      true
    else
      on_failure.call(errors) if block_given?
      false
    end
  end
  module_function *self.instance_methods
end
