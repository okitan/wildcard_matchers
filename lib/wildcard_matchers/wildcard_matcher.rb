module WildcardMatchers
  class WildcardMatcher
    attr_reader :expectation, :errors
    attr_accessor :position

    def initialize(expectation = nil, position = ".", &block)
      @expectation = (block_given? ? block : expectation)
      @position    = position
    end

    def ===(actual)
      @errors = []
      wildcard_match_with_catch_exception(actual)
      errors.empty?
    end

    def self.check_errors(actual, expectation = nil, position = ".", &block)
      expectation = (block_given? ? block : expectation)
      matcher = self.new(expectation, position)
      matcher === actual
      matcher.errors
    end

    protected
    # I'd like to use prepend
    def wildcard_match_with_catch_exception(actual)
      wildcard_match(actual)
    rescue => e
      errors.push "#{position}: <#{e.inspect}:#{e.message}> for expect #{actual.inspect} to #{expectation.inspect}"
    end

    def wildcard_match(actual)
      case expectation
      when self.class
        expectation.position = position
        expectation === actual
        errors.push(*expectation.errors)
      when Class
        # fo Array or Hash Class
        single_match(actual)
      when Proc
        # TODO: use sexp
        single_match(actual)
      when Method
        errors.push(*MethodMatcher.check_errors(actual, expectation, position))
      when Array
        errors.push(*ArrayMatcher.check_errors(actual, expectation, position))
      when Hash
        errors.push(*HashMatcher.check_errors(actual, expectation, position))
      else
        if defined?(::RSpec::Matchers::DSL::Matcher) \
            && ::RSpec::Matchers::DSL::Matcher === expectation \
            && (expected = expectation.expected.first).is_a?(self.class)
          # if duplicated wildcard_match extract it
          expected === actual
          errors.push(*expected.errors)
        else
          single_match(actual)
        end
      end
    end

    def single_match(actual)
      unless expectation === actual
        errors << "#{position}: expect #{actual.inspect} to #{expectation.inspect}"
      end
    end
  end

  class ArrayMatcher < WildcardMatcher
    protected
    def wildcard_match(actual)
      unless actual and actual.is_a?(Array)
        errors << "#{position}: expect #{actual.inspect} to #{expectation.inspect}"
        return
      end

      if expectation.size === actual.size
        expectation.zip(actual).each.with_index do |(e, a), i|
          errors.push(*self.class.superclass.check_errors(a, e, position + "[#{i}]"))
        end
      else
        errors << "#{position}: expect Array size #{actual.size} to #{expectation.size}"
        # TODO: diff-lcs
      end
    end
  end

  class HashMatcher < WildcardMatcher
    protected
    def wildcard_match(actual)
      unless actual and actual.is_a?(Hash)
        errors << "#{position}: expect #{actual.inspect} to #{expectation.inspect}"
        return
      end

      if (actual.keys - expectation.keys).size == 0 && (expectation.keys - actual.keys).size == 0
        expectation.each do |key, value|
          errors.push(*self.class.superclass.check_errors(actual[key], value, position + "[#{key.inspect}]"))
        end
      else
        begin
          actual_keys   = actual.keys.sort
          expected_keys = expectation.keys.sort

          extra = actual_keys   - expected_keys
          short = expected_keys - actual_keys

          errors << "#{position}: expect Hash keys #{actual_keys} to #{expected_keys}\n  extra: #{extra}\n  short: #{short}"
        rescue
          # when keys has more patterns than expacted
          errors << "#{position}: expect Hash keys #{actual.keys} to #{expectation.keys}"
        end
      end
    end
  end

  class MethodMatcher < WildcardMatcher
    protected
    def wildcard_match(actual)
      result = expectation.call(actual)

      unless result
        errors << "#{position}: expect #{expectation.receiver.inspect}.#{expectation.name} return true but #{result}"
      end
    end
  end
end
