module WildcardMatchers
  module Helpers
    def nil_or(expected = nil, &block)
      raise "expected or block is mandatory" unless expected or block_given?

      expected ||= block
      lambda do |actual|
        nil === actual or wildcard_match?(actual, expected)
      end
    end

    def with_array(&block)

    end
  end
end
