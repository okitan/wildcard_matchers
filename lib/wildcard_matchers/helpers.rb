module WildcardMatchers
  module Helpers
    def nil_or(expected, &on_failure)
      lambda do |actual|
        nil === actual or wildcard_match?(actual, expected, &on_failure)
      end
    end

    def for_all(expected = nil, &on_failure)
      raise "expected or block is mandatory" unless expected or block_given?

      expected ||= block
      lambda do |actual|
        actual.all? do |item|
          wildcard_match?(item, expected, &on_failure)
        end
      end
    end
  end
end
