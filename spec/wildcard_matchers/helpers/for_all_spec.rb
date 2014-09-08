require "spec_helper"

describe WildcardMatchers::Helpers::ForAll do
  [ [ %w[ a b c ], :for_all, String ],
    [ %w[ a b c ], :for_all, :is_a_string ],
    [ %w[ a b c ], :for_all, :is_a, String ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end

  it "should match using lambda with helper" do
    expect([ 2, 4, 6]).to wildcard_match(for_all ->(item) { item % 2 == 0 })
  end
end
