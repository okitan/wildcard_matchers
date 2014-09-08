require "spec_helper"

describe WildcardMatchers::Matchers::HashIncludes do
  [ [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => 1 ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => Integer ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :d ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => 2 ],
    [ { :a => 1, :b => 1, :c => 1 }, :hash_includes, :a, :b => String ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end

  # bug
  it "cannot be corrupted" do
    matcher = hash_includes(a: 1)
    2.times { expect(wildcard_match?({ a: 2 }, matcher, &debugger)).to be false }
  end
end
