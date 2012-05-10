shared_examples_for :wildcard_match_matches do |actual, expected|
  it "#{actual.inspect} with #{expected.inspect}" do
    wildcard_match?(actual, expected).should be_true
  end
end

shared_examples_for :wildcard_match_not_matches do |actual, expected|
  it "#{actual.inspect} with #{expected.inspect}" do
    wildcard_match?(actual, expected).should be_false
  end
end
