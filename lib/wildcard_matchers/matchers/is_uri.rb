require "addressable/uri"

module WildcardMatchers
  module Matchers
    def is_uri(hash = {})
      IsUri.new(hash)
    end

    class IsUri < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        unless actual
          return errors.push "#{position}: expect URI but nil"
        end

        uri = ::Addressable::URI.parse(actual) # if actual is ::URI re-parse

        expectation.each do |key, value|
          errors.push(*self.class.superclass.check_errors(uri.__send__(key), value, position + "[#{key.inspect}]"))
        end
      end
    end
  end
end
