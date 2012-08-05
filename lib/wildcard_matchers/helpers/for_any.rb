module WildcardMatchers
  module Helpers
    define_wildcard_helper(:for_any)

    class ForAny < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        unless actual.any? {|e| self.class.superclass.check_errors(e, expectation) == [] }
          errors.push("expect #{actual} has #{expectation}")
        end
      end
    end
  end
end
