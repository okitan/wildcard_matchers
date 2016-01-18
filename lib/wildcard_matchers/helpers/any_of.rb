module WildcardMatchers
  module Helpers
    define_wildcard_helper(:any_of)

    class AnyOf < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        errors = expectation.map do |e|
          self.class.superclass.check_errors(actual, e)
        end

        unless errors.any? {|e| e == [] }
          @errors = errors.flatten
        end
      end
    end
  end
end
