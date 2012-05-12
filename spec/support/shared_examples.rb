shared_examples_for "wildcard match" do |actual, matcher, *args|
  expected = matcher.inspect + (args.size > 0 ? "(#{args.map(&:inspect).join(", ")})" : "")

  it "#{actual.inspect} with #{expected}" do
    if matcher.is_a?(Symbol) and WildcardMatchers.respond_to?(matcher)
      # Note: some symbol comes here and may fail
      wildcard_match?(actual, send(matcher, *args)).should be_true
    else
      wildcard_match?(actual, matcher).should be_true
    end
  end
end

shared_examples_for "not wildcard match" do |actual, matcher, *args|
  expected = matcher.inspect + (args.size > 0 ? "(#{args.map(&:inspect).join(", ")})" : "")

  it "#{actual.inspect} with #{expected}" do
    if matcher.is_a?(Symbol) and WildcardMatchers.respond_to?(matcher)
      # Note: some symbol comes here and may fail
      wildcard_match?(actual, send(matcher, *args)).should be_false
    else
      wildcard_match?(actual, matcher).should be_false
    end
  end
end
