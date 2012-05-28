require "spec_helper"

describe "matcher wildcard_match" do
  [ [ 1, Integer ],
  ].each do |actual, expected|
    it "match #{actual.inspect} with #{expected}" do
      actual.should wildcard_match(expected)
    end
  end

  [ [ "1", :is_a_string ],
  ].each do |actual, expected|
    it "match #{actual.inspect} with #{expected}" do
      actual.should wildcard_match(send(expected))
    end
  end

  [ [ 1,           String,     ".: expect 1 to String" ],
    [ [ 1 ],       [ String ], ".[0]: expect 1 to String" ],
    [ [ 1 ],       [],         ".: expect Array size 1 to 0" ],
    [ { :a => 1 }, {},         "+keys: [:a]" ],
    [ {},          {:a => 1},  "-keys: [:a]" ],
    [ { :a => 1},  {:a => 0},  ".[:a]: expect 1 to 0" ],
  ].each do |actual, expected, failure_message|
    it "not match #{actual.inspect} with #{expected} and return #{failure_message.inspect} as failure_message" do
      begin
        actual.should wildcard_match(expected)
        fail # if matched come here and must fail
      rescue => e
        e.message.should include(failure_message)
      end
    end
  end
end
