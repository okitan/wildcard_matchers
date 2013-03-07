require "addressable/template"

module WildcardMatchers
  module Matchers
    define_wildcard_matcher(:with_uri_template)

    class WithUriTemplate < ::WildcardMatchers::WildcardMatcher
      def initialize(expectations, position = ".", &block)
        template, expectation = *expectations

        @template    = template.is_a?(::Addressable::Template) ? template : ::Addressable::Template.new(template)

        @expectation = (block_given? ? block : expectation)
        @position    = position
      end

      protected
      def wildcard_match(actual)
        extracted = @template.extract(actual)

        errors.push(*self.class.superclass.check_errors(extracted, expectation, position))
      end
    end
  end
end
