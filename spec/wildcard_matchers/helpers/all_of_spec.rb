require "spec_helper"

describe WildcardMatchers::Helpers::AllOf do
  [ [ "a", :all_of, [ String, /a/ ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end

  [ [ "a", :all_of, [ Integer, /a/ ] ],
    [ "a", :all_of, [ String,  /b/ ] ],
    [ "a", :all_of, [ Integer, /b/ ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "not wildcard match with helper", actual, helper, matcher, *args
  end
end
