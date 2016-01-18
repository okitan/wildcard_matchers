require "spec_helper"

describe WildcardMatchers::Matchers do
  [ [ "string",            String ],
    [ 0,                   Integer ],
    [ 0.1,                 Float ],
    [ 0,                   Numeric ],  # superclass
    [ { :some => :hash },  Hash  ],
    [ [ 1, 2, 3 ],         Array ],
  ].each do |actual, expected|
    it_behaves_like "wildcard match", actual, :is_a, expected
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
    it_behaves_like "wildcard match", actual, matcher
  end

  [ [ 0, :is_bool ],
  ].each do |actual, matcher|
    it_behaves_like "not wildcard match", actual, matcher
  end

  [ [ "a", :is_a_member_of, %w[ a b ] ],
    [ "a", :is_a_member_of, [ String ] ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ "a", :is_a_member_of, %w[ b c ] ],
    [ "a", :is_a_member_of, [ Integer ] ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end

  context "composing matchers" do
    context "with &" do
      include WildcardMatchers

      it "works" do
        matcher = responding(size: 2) & /a/ & /b/
        expect(wildcard_match?("ab", matcher, &debugger)).to be true
      end

      it "shows every erro4" do
        matcher = responding(size: 2) & /a/ & /b/
        expect(wildcard_match?("c", matcher, &debugger)).to be false
      end

      it "returns error just one mismatch" do
        matcher = responding(size: 1) & /a/ & /b/
        expect(wildcard_match?("a", matcher, &debugger)).to be false
      end

      it "is also available for all_of" do
        matcher = all_of([String, /a/]) & /b/
        expect(wildcard_match?("a", matcher, &debugger)).to be false
      end
    end

    context "with |" do
      include WildcardMatchers

      it "works" do
        matcher = responding(size: 2) | /a/ | /b/
        expect(wildcard_match?("a", matcher, &debugger)).to be true
      end

      it "shows every error" do
        matcher = responding(size: 2) | /a/ | /b/
        expect(wildcard_match?("c", matcher, &debugger)).to be false
      end

      it "is also available for any_of" do
        matcher = any_of([Integer, /a/]) | /b/
        expect(wildcard_match?("b", matcher, &debugger)).to be true
      end

      it "is also available for any_of" do
        matcher = any_of([Integer, /b/]) | /a/
        expect(wildcard_match?("b", matcher, &debugger)).to be true
      end
    end
  end
end
