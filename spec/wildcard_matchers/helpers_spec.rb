require "spec_helper"

describe WildcardMatchers::Helpers do
  context "with nil_or" do
    [ [ nil,   String ],
      [ "aaa", String ],
      [ nil,   :is_a_string ],
      [ "aaa", :is_a_string ],
    ].each do |actual, expected|
      it_should_behave_like "wildcard match with helper", actual, :nil_or, expected
    end
  end
end
