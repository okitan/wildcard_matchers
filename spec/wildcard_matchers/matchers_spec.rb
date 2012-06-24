require "spec_helper"

describe WildcardMatchers::Matchers do
  [ [ "string",            String ],
    [ 0,                   Integer ],
    [ 0.1,                 Float ],
    [ 0,                   Numeric ],  # superclass
    [ { :some => :hash },  Hash  ],
    [ [ 1, 2, 3 ],         Array ],
  ].each do |actual, expected|
    it_should_behave_like "wildcard match", actual, :is_a, expected
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

  [ [ 0, :is_bool ],
  ].each do |actual, matcher|
    it_should_behave_like "not wildcard match", actual, matcher
  end

  [ [ "a", :is_a_member_of, %w[ a b ] ],
    [ "a", :is_a_member_of, [ String ] ],
  ].each do |actual, matcher, *args|
    it_should_behave_like "wildcard match", actual, matcher, *args
  end

  [ [ "a", :is_a_member_of, %w[ b c ] ],
    [ "a", :is_a_member_of, [ Integer ] ],
  ].each do |actual, matcher, *args|
    it_should_behave_like "not wildcard match", actual, matcher, *args
  end
end
