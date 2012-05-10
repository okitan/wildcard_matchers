require "spec_helper"

shared_examples_for "wildcard match with args" do |actual, matcher, *args|
  it "match #{actual.inspect} with #{matcher.inspect}(#{args.map(&:inspect).join(", ")})" do
    wildcard_match?(actual, send(matcher, *args)).should be_true
  end
end

describe WildcardMatchers::Matchers do
  include WildcardMatchers

  [ [ "string",            String ],
    [ 0,                   Integer ],
    [ 0.1,                 Float ],
    [ 0,                   Numeric ],  # superclass
    [ { :some => :hash },  Hash  ],
    [ [ 1, 2, 3 ],         Array ],
  ].each do |actual, expected|
    it_should_behave_like "wildcard match with args", actual, :is_a, expected
  end

  [ [ "string",           :is_a_string ],
    [ 0,                  :is_a_integer ],
    [ 0.1,                :is_a_float ],
    [ { :some => :hash }, :is_a_hash ],
    [ [ 1, 2, 3 ],        :is_a_array ],

    # is_bool
    [ true,  :is_bool ],
    [ false, :is_bool ],

    # is_time
    [ Time.now,      :is_time ],
    [ Time.now.to_s, :is_time ],
    [ "2012-05-10",  :is_time ],

  ].each do |actual, matcher|
    it_should_behave_like "wildcard match", actual, matcher
  end

  [ # hash_including
    [ { :a => 1, :b => 1, :c => 1 }, :hash_including, :a, :b ],
  ].each do |actual, matcher, *args|
    it_should_behave_like "wildcard match with args", actual, matcher, *args
  end
end
