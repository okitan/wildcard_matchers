require "spec_helper"

describe WildcardMatchers::Helpers::ForAny do
  [ [ %w[ a b c ], :for_any, String ],
    [ [ 1, "1" ],  :for_any, String ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end

  it "should match using lambda with helper" do
    [ 1, 2, 3 ].should wildcard_match(for_any ->(item) { item % 2 == 0 })
  end
end
