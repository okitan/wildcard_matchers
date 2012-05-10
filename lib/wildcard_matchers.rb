require "wildcard_matchers/matchers"

module WildcardMatchers
  include Matchers

  def wildcard_match?(actual, expected, &on_failure)
    on_failure = proc { return false } unless block_given?

    case expected
    when Class
      # when expected is really Array or Hash comes here and do nothing
    when Array
      return check_array(actual, expected, &on_failure)
    when Hash
      return check_hash(actual, expected, &on_failure)
    end

    single_match(actual, expected, &on_failure)
  end

  protected
  def single_match(actual, expected, &callback)
    unless expected === actual
      yield("expect #{actual.inspect} to #{expected.inspect}")
      false
    else
      true
    end
  end

  def check_array(actual, expected, &on_failure)
    return false unless single_match(actual, Array, &on_failure)

    if expected.size == actual.size
      actual.zip(expected).inject(true) do |result, (a, e)|
        result & wildcard_match?(a, e, &on_failure)
      end
    else
      yield <<_MESSAGE_
expect Array size #{actual.size} to #{expected.size}"
  actual: #{actual.inspect}
  expect: #{expected.inspect}
_MESSAGE_
      false
    end
  end

  def check_hash(actual, expected, &on_failure)
    return false unless single_match(actual, Hash, &on_failure)

    if expected.keys.size == (actual.keys & expected.keys).size
      expected.inject(true) do |result, (key, value)|
        result & wildcard_match?(actual[key], value, &on_failure)
      end
    else
      yield <<_MESSAGE_
expect Hash keys #{actual.size} to #{expected.size}"
  +keys: #{actual.keys   - expected.keys}
  -keys: #{expected.keys - actual.keys }
_MESSAGE_
      false
    end
  end
end
