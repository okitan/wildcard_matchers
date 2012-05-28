require "spec_helper"

describe WildcardMatchers::Helpers do
  context "with nil_or" do
    [ [ nil,   :nil_or, String ],
      [ "aaa", :nil_or, String ],
      [ nil,   :nil_or, :is_a_string ],
      [ "aaa", :nil_or, :is_a_string ],
      [ %w[ a b c ], :all, String ],
      [ %w[ a b c ], :all, :is_a_string ],
      [ %w[ a b c ], :all, :is_a, String ],
    ].each do |actual, helper, matcher, *args|
      it_should_behave_like "wildcard match with helper", actual, helper, matcher, *args
    end
  end
end
