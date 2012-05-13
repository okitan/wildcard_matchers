require "wildcard_matchers/matchers"

module WildcardMatchers
  include Matchers

  def wildcard_match?(actual, expected, &on_failure)
    on_failure = proc { return false } unless block_given?

    recursive_match(actual, expected, &on_failure)
  end

  protected
  def recursive_match(actual, expected, position = ".", &on_failure)
    # "case expected" should omit Array or Hash
    # "case actual" should omit Proc
    case expected
    when Class
      # when expected is Array or Hash (Class) comes here and do nothing
    when Array
      return check_array(actual, expected, position, &on_failure)
    when Hash
      return check_hash(actual, expected, position, &on_failure)
    end

    unless expected === actual
      yield("#{position}: expect #{actual.inspect} to #{expected.inspect}")
      false
    else
      true
    end
  end

  # TODO: class ArrayMatcher ?
  def check_array(actual, expected, position, &on_failure)
    return false unless actual.is_a?(Array)

    if expected.size == actual.size
      actual.zip(expected).map.with_index do |(a, e), index|
        recursive_match(a, e, position + "[#{index}]", &on_failure)
      end.all?
    else
      yield <<_MESSAGE_
#{position}: expect Array size #{actual.size} to #{expected.size}
  actual: #{actual.inspect}
  expect: #{expected.inspect}
_MESSAGE_
      false
    end
  end

  # TODO: class HashMatcher ?
  def check_hash(actual, expected, position, &on_failure)
    return false unless actual.is_a?(Hash)

    if (actual.keys - expected.keys).size == 0 && (expected.keys - actual.keys).size == 0
      expected.map do |key, value|
        recursive_match(actual[key], value, position + "[#{key.inspect}]", &on_failure)
      end.all?
    else
      yield <<_MESSAGE_
#{position}: expect Hash keys #{actual.size} to #{expected.size}
  +keys: #{actual.keys   - expected.keys}
  -keys: #{expected.keys - actual.keys }
_MESSAGE_
      false
    end
  end

  module_function *self.instance_methods
end
