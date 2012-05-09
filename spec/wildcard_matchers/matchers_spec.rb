require "spec_helper"

describe WildcardMatchers::Matchers do
  include WildcardMatchers

  context ".is_a can be used" do
    [ [ "string",            String ],
      [ 0,                   Integer ],
      [ 0.1,                 Float ],
      [ 0,                   Numeric ],  # superclass
      [ { :some => :hash },  Hash  ],
      [ [ 1, 2, 3 ],         Array ],
    ].each do |actual, expected|
      it "to match #{actual.inspect} with is_a(#{expected.inspect})" do
        wildcard_match?(actual, is_a(expected)).should be_true
      end
    end
  end

  [ [ "string",           :is_a_string ],
    [ 0,                  :is_a_integer ],
    [ 0.1,                :is_a_float ],
    [ { :some => :hash }, :is_a_hash ],
    [ [ 1, 2, 3 ],        :is_a_array ],
  ].each do |actual, expected|
    it ".#{expected} matches with #{actual.inspect}" do
      wildcard_match?(actual, send(expected)).should be_true
    end
  end
end
