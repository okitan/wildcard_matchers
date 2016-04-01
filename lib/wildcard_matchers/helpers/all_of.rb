module WildcardMatchers
  module Helpers
    define_wildcard_helper(:all_of)

    class AllOf < ::WildcardMatchers::WildcardMatcher
      def &(matcher)
        expectation.push(matcher)
        self
      end

      protected
      def wildcard_match(actual)
        errors = expectation.map do |e|
          self.class.superclass.check_errors(actual, e, position)
        end.flatten

        unless errors.empty?
          @errors = errors
        end
      end
    end
  end
end
