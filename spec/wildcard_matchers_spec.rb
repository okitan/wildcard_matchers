require "spec_helper"

target = WildcardMatchers

describe target do
  include target

  context ".wildcard_match?" do
    [ [ "string",            String ],
      [ "string",            /^str/ ],
      [ 0,                   Integer ],
      [ 2,                   (1..3) ],
      [ 0.1,                 Float ],
      [ 0,                   Numeric ],  # superclass
      [ { :some => :hash },  Hash  ],
      [ [ 1, 2, 3 ],         Array ],
      [ 1,                   ->(v) { [1,2,3].include?(v) } ],
      [ 1,                   [1,2,3].method(:include?) ],
    ].each do |actual, expected|
      it_behaves_like "wildcard match", actual, expected
    end

    [ [ {}, [] ],
      [ [], {} ],
    ].each do |actual, expected|
      it_behaves_like "not wildcard match", actual, expected
    end

    context "matches recursively in Array" do
      [ [ [ 1, 2, "3"],    [ Integer, Integer, String ] ],
        [ [ 1, 2, [ 1 ] ], [ Integer, Integer, [ Integer ] ] ],
      ].each do |actual, expected|
        it_behaves_like "wildcard match", actual, expected
      end
    end

    context "does not match recursively in Array" do
      [ [ [ 1, 2, 3 ],     [ Integer, Integer, String ] ],
        [ [ 1, 2, 3 ],    [ Integer, String,  Integer ] ],
        [ [ 1, 2, [ 1 ] ], [ Integer, Integer, [ String ] ] ],
      ].each do |actual, expected|
        it_behaves_like "not wildcard match", actual, expected
      end
    end

    context "matches recursively in Hash" do
      [ [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :fuga => String } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :ugu => String } } ],
      ].each do |actual, expected|
        it_behaves_like "wildcard match", actual, expected
      end
    end

    context "matches recursively in Hash" do
      [ [ { :hoge => "fuga" },                 {} ],
        [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :fuga => Integer } ],
        [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :ugu => String } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :ugu => Integer } } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :fuga => String } } ],
      ].each do |actual, expected|
        it_behaves_like "not wildcard match", actual, expected
      end
    end

    # TODO: more complex example array in hash and hash in array
    context "match recursively Array and Hash" do
      [ [ [ 1, [ 2 ], { :first => 4, :second => [ 5, 6 ] } ],
          [ Integer, [ Integer ], { :first => Integer, :second => [ Integer, Integer ] } ] ],

        [ { :first => 1, :second => [ 2 ], :third => { :one => 3 } },
          { :first => Integer, :second => [ Integer ], :third => { :one => Integer } }
        ]
      ].each do |actual, expected|
        it_behaves_like "wildcard match", actual, expected
      end
    end
  end

  context ".wildcard_matches with on_failure callback" do
    it "can get failure message" do
      actual   = true
      expected = false

      failure = nil
      wildcard_match?(actual, expected) {|errors| failure = errors }
      expect(failure).to wildcard_match([/#{actual.inspect} .+ #{expected.inspect}/])
    end

    it "can get several failure messages" do
      actual   = [ 1, 0, 2 ]
      expected = [ 3, 0, 4 ]

      failure = nil
      wildcard_match?(actual, expected) {|errors| failure = errors }

      expect_failures = [ /#{actual.first}.+#{expected.first}/,
                          /#{actual.last}.+#{expected.last}/ ]
      expect(failure).to wildcard_match(expect_failures)
    end

    # TODO: more failure message
  end
end
