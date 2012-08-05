module WildcardMatchers
  module Helpers
    def for_any(expectation = nil, &block)
      expectation = block_given? ? block : expectation

      ForAny.new(expectation)
    end

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
