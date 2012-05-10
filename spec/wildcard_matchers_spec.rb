require "spec_helper"

target = WildcardMatchers

shared_examples_for :wildcard_match_matches do |actual, expected|
  it "#{actual.inspect} with #{expected.inspect}" do
    debug = proc {|message| p message }
    wildcard_match?(actual, expected, &debug).should be_true
  end
end

shared_examples_for :wildcard_match_not_matches do |actual, expected|
  it "#{actual.inspect} with #{expected.inspect}" do
    debug = proc {|message| p message }
    wildcard_match?(actual, expected, &debug).should be_false
  end
end

describe target do
  include target

  context ".wildcard_match?" do
    [ [ "string",            String ],
      [ "string",            /^str/ ],
      [ 0,                   Integer ],
      [ 0.1,                 Float ],
      [ 0,                   Numeric ],  # superclass
      [ { :some => :hash },  Hash  ],
      [ [ 1, 2, 3 ],         Array ],
    ].each do |actual, expected|
      it_should_behave_like :wildcard_match_matches, actual, expected
    end

    context "matches recursively in Array" do
      [ [ [ 1, 2, "3"],    [ Integer, Integer, String ] ],
        [ [ 1, 2, [ 1 ] ], [ Integer, Integer, [ Integer ] ] ],
      ].each do |actual, expected|
        it_should_behave_like :wildcard_match_matches, actual, expected
      end
    end

    context "does not match recursively in Array" do
      [ [ [ 1, 2, 3 ],     [ Integer, Integer, String ] ],
        [ [ 1, 2, 3 ],    [ Integer, String,  Integer ] ],
        [ [ 1, 2, [ 1 ] ], [ Integer, Integer, [ String ] ] ],
      ].each do |actual, expected|
        it_should_behave_like :wildcard_match_not_matches, actual, expected
      end
    end

    context "matches recursively in Hash" do
      [ [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :fuga => String } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :ugu => String } } ],
      ].each do |actual, expected|
        it_should_behave_like :wildcard_match_matches, actual, expected
      end
    end

    context "matches recursively in Hash" do
      [ [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :fuga => Integer } ],
        [ { :hoge => "fuga", :fuga => "ugu" }, { :hoge => String, :ugu => String } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :ugu => Integer } } ],
        [ { :hoge => "fuga", :fuga => { :ugu => "piyo" } }, { :hoge => String, :fuga => { :fuga => String } } ],
      ].each do |actual, expected|
        it_should_behave_like :wildcard_match_not_matches, actual, expected
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
        it_should_behave_like :wildcard_match_matches, actual, expected
      end
    end
  end

  context ".wildcard_matches with on_failure callback" do
    context "without callback" do
      it "returns false" do
        wildcard_match?(true, false).should be_false
      end
    end

    context "with callback" do
      [ [ true, false ],
      ].each do |actual, expected|
        it "can get failure message" do
          failure = nil
          wildcard_match?(actual, expected) {|message| failure = message }
          failure.should =~ /#{actual.inspect} .+ #{expected.inspect}/
        end
      end

      # TODO: more failure message
    end
  end
end
