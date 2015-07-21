require "spec_helper"

describe WildcardMatchers::Matchers::HashIncludes do
  [ [ [ 1, 2, 3 ], :bag_of, 3, 2, 1 ],
    [ [ 1, 2, 3 ], :bag_of, 1, 2, 3 ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ [ 1, 2, 3 ], :bag_of, 1, 2 ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end
end
