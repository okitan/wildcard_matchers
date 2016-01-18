require "spec_helper"

describe WildcardMatchers::Helpers::AnyOf do
  [ [ "a", :any_of, [ String,  /b/ ] ],
    [ "a", :any_of, [ Integer, /a/ ] ],
    [ "a", :any_of, [ String,  /a/ ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end

  [ [ "a", :any_of, [ Integer, /b/ ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "not wildcard match with helper", actual, helper, matcher, *args
  end
end
