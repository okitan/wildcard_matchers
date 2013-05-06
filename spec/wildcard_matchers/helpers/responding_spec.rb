require "spec_helper"

describe WildcardMatchers::Helpers::Responding do
  [ [ Struct.new(:hoge).new("fuga"), :responding, { hoge: "fuga" } ],
  ].each do |actual, helper, matcher, *args|
    it_behaves_like "wildcard match with helper", actual, helper, matcher, *args
  end
end
