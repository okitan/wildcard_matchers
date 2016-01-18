module WildcardMatchers
  module Helpers
    class << self
      def define_wildcard_helper(name)
        define_method(name) do |expectation = nil, &block|
          expectation = block_given? ? block : expectation

          ::WildcardMatchers::Helpers.const_get(name.to_s.camelcase(:upper)).new(expectation)
        end
      end
    end
  end
end

require "wildcard_matchers/helpers/any_of"
require "wildcard_matchers/helpers/all_of"
require "wildcard_matchers/helpers/for_any"
require "wildcard_matchers/helpers/for_all"
require "wildcard_matchers/helpers/nil_or"
require "wildcard_matchers/helpers/responding"
