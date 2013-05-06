module WildcardMatchers
  module Helpers
    define_wildcard_helper(:responding)

    class Responding < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        expectation.each do |key, value|
          errors.push(*self.class.superclass.check_errors(actual.__send__(key), value, position + ".#{key}"))
        end
      end
    end
  end
end
