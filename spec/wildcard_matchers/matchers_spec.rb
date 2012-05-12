require "spec_helper"

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

  [ [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => 1 ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => Integer ],
  ].each do |actual, matcher, *args|
    it_should_behave_like "wildcard match with args", actual, matcher, *args
  end

  [ [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :d ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => 2 ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => String ],
  ].each do |actual, matcher, *args|
    it_should_behave_like "not wildcard match with args", actual, matcher, *args
  end
end
