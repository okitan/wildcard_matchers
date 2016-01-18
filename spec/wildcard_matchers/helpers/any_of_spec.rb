require "spec_helper"

describe WildcardMatchers::Helpers::AnyOf do
  [ [ "a", :any_of, [ String, Integer ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end

  [ [ "a", :any_of, [ Integer, true ] ],
    [ "a", :any_of, [ Integer, true ] ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "not wildcard match with helper", actual, helper, matcher, *args
  end
end
