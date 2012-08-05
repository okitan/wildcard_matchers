require "spec_helper"

describe WildcardMatchers::Matchers::IsUri do
  [ [ "http://example.com", :is_uri ],
    [ "http://example.com", :is_uri, :scheme => "http", :host => "example.com" ],
    [ "http://example.com", :is_uri, :host => /example/ ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ "http://example.com", :is_uri, :host => "google.com" ],
    [ "http://example.com", :is_uri, :host => /google/ ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end

  context "when you use addressable, :query_values also available" do
    [ [ "http://example.com/?hoge=fuga", :is_uri, :query_values => { "hoge" => /fu/ } ],
    ].each do |actual, matcher, *args|
      it_behaves_like "wildcard match", actual, matcher, *args
    end

    [ [ "http://example.com/?hoge=fuga", :is_uri, :query_values => { "hoge" => /ho/ } ],
    ].each do |actual, matcher, *args|
      it_behaves_like "not wildcard match", actual, matcher, *args
    end
  end
end
