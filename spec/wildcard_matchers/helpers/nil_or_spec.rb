require "spec_helper"

describe WildcardMatchers::Helpers::NilOr do
  [ [ nil,   :nil_or, String ],
    [ "aaa", :nil_or, String ],
    [ nil,   :nil_or, :is_a_string ],
    [ "aaa", :nil_or, :is_a_string ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end
end
