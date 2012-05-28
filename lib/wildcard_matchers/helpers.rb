module WildcardMatchers
  module Helpers
    def nil_or(expected = nil, &block)
      raise "expected or block is mandatory" unless expected or block_given?

      expected ||= block
      lambda do |actual|
        nil === actual or wildcard_match?(actual, expected)
      end
    end

    def is_all(expected = nil, &block)
      raise "expected or block is mandatory" unless expected or block_given?

      expected ||= block
      lambda do |actual|
        actual.all? do |item|
          expected === item
        end
      end
    end
  end
end
