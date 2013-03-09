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

      def without_query!
        @without_query = true

        # umhhh
        uri = ::Addressable::URI.parse(@template.pattern.split("{?").first)

        @template_without_query = ::Addressable::Template.new(uri.omit(:query).to_s)

        self
      end

      protected
      def wildcard_match(actual)
        unless actual
          return errors.push("#{position}: expect URI but nil")
        end

        if @without_query
          uri = ::Addressable::URI.parse(actual)

          params = uri.query_values || {}

          unless extracted = @template_without_query.extract(uri.omit!(:query).to_s)
            return errors.push("#{position}: expect #{uri.to_s} to match #{@template_without_query.pattern}")
          end

          errors.push(*self.class.superclass.check_errors(extracted.merge(params), expectation, position))
        else
          unless extracted = @template.extract(actual)
            return errors.push("#{position}: expect #{actual} to match #{@template.pattern}")
          end

          errors.push(*self.class.superclass.check_errors(extracted, expectation, position))
        end
      end
    end
  end
end
