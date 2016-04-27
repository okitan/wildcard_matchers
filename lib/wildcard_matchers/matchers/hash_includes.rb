module WildcardMatchers
  module Matchers
    # RSpeck::Mocks has hash_including
    define_wildcard_matcher(:hash_includes)

    class HashIncludes < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        unless actual && actual.is_a?(Hash)
          errors.push "#{position}: expect #{actual.inspect} to Hash"
          return
        end

        expectation.each do |key|
          unless key.is_a?(Hash)
            errors << "#{position}: expect #{actual} to have key #{key}" unless actual.has_key?(key)
          else
            key.each do |key, value|
              unless actual.has_key?(key)
                errors << "#{position}: expect #{actual} to have key #{key}"
              else
                errors.push(*self.class.superclass.check_errors(actual[key], value, position + "[#{key.inspect}]"))
              end
            end
          end
        end
      end
    end
  end
end
