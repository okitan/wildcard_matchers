module WildcardMatchers
  module Helpers
    def for_all(expectation, &block)
      expectation = block_given? ? block : expectation

      ForAll.new(expectation)
    end

    class ForAll < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        actual.each.with_index do |e, i|
          errors.push(*self.class.superclass.check_errors(e, expectation, position + "[#{i}]"))
        end
      end
    end
  end
end
