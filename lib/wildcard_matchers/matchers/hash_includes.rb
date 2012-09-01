module WildcardMatchers
  module Matchers
    # RSpeck::Mocks has hash_including
    define_wildcard_matcher(:hash_includes)

    class HashIncludes < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        unless actual.is_a?(Hash)
          errors.push "#{position}: expect #{actual} to Hash"
        end

        hash_to_match = {}
        hash_to_match = expectation.pop if expectation.last.is_a?(Hash)

        expectation.each do |key|
          errors << "#{position}: expect #{actual} to have key #{key}" unless actual.has_key?(key)
        end

        hash_to_match.each do |key, value|
          errors.push(*self.class.superclass.check_errors(actual[key], value, position + "[#{key.inspect}]"))
        end
      end
    end
  end
end
