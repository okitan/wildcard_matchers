module WildcardMatchers
  module Helpers
    def nil_or(expectation, &block)
      expectation = block_given? ? block : expectation

      NilOr.new(expectation)
    end

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
