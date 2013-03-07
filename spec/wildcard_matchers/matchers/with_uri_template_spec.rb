require "spec_helper"

describe WildcardMatchers::Matchers::WithUriTemplate do
  [ [ "http://example.com/hoge/fuga", :with_uri_template, "http://example.com/hoge/{fuga}", "fuga" => "fuga" ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ "http://example.com/hoge/fuga", :with_uri_template, "http://example.com/hoge/{fuga}", "fuga" => "hoge" ],
    [ "http://example.com/hoge/fuga", :with_uri_template, "http://example.com/hoge/{fuga}", "hoge" => "fuga" ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end
end
