module WildcardMatchers
  module Matchers
    define_wildcard_matcher(:bag_of)

    class BagOf < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        errors.push(*WildcardMatchers::ArrayMatcher.check_errors(actual.sort, expectation.sort, position))
      end
    end
  end
end
