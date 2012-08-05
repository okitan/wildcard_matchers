module WildcardMatchers
  module Helpers
    define_wildcard_helper(:nil_or)

    class NilOr < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        unless actual.nil?
          errors.push(*self.class.superclass.check_errors(actual, expectation, position))
        end
      end
    end
  end
end
