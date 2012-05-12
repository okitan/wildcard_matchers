shared_examples_for "wildcard match" do |actual, matcher|
  it "#{actual.inspect} with #{matcher.inspect}" do
    if matcher.is_a?(Symbol) and self.respond_to?(matcher)
      # Note: some symbol comes here and may fail
      wildcard_match?(actual, send(matcher)).should be_true
    else
      wildcard_match?(actual, matcher).should be_true
    end
  end
end

shared_examples_for "not wildcard match" do |actual, expected|
  it "#{actual.inspect} with #{expected.inspect}" do
    wildcard_match?(actual, expected).should be_false
  end
end

shared_examples_for "wildcard match with args" do |actual, matcher, *args|
  it "match #{actual.inspect} with #{matcher.inspect}(#{args.map(&:inspect).join(", ")})" do
    wildcard_match?(actual, send(matcher, *args)).should be_true
  end
end

shared_examples_for "not wildcard match with args" do |actual, matcher, *args|
  it "not match #{actual.inspect} with #{matcher.inspect}(#{args.map(&:inspect).join(", ")})" do
    wildcard_match?(actual, send(matcher, *args)).should be_false
  end
end
