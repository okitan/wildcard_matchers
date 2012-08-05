module WildcardMatchers
  module Helpers
    define_wildcard_helper(:for_all)

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
