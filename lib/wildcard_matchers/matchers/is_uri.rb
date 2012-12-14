module WildcardMatchers
  module Matchers
    def is_uri(hash = {})
      IsUri.new(hash)
    end

    class IsUri < ::WildcardMatchers::WildcardMatcher
      protected
      def wildcard_match(actual)
        uri = nil
        begin
          require "addressable/uri"
          uri = ::Addressable::URI.parse(actual) # if actual is ::URI re-parse
        rescue LoadError
          require "uri"
          uri = actual.is_a?(::URI) ? actual : ::URI.parse(actual)
        end

        expectation.each do |key, value|
          errors.push(*self.class.superclass.check_errors(uri.__send__(key), value, position + "[#{key.inspect}]"))
        end
      end
    end
  end
end
