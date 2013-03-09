require "spec_helper"

describe WildcardMatchers::Matchers::WithUriTemplate do
  extend WildcardMatchers::Matchers

  [ [ "http://example.com/hoge/fuga",           :with_uri_template, "http://example.com/{hoge}/{fuga}",
                                                                    "hoge" => "hoge", "fuga" => "fuga" ],
    [ "http://example.com/hoge/fuga",           :with_uri_template, "http://example.com{/hoge,fuga}",
                                                                    "hoge" => "hoge", "fuga" => "fuga" ],
    [ "http://example.com/?hoge=fuga&fuga=ugu", :with_uri_template, "http://example.com/{?hoge,fuga}",
                                                                    "hoge" => "fuga", "fuga" => "ugu" ],
    [ "http://example.com/?hoge=fuga&fuga=ugu", :with_uri_template, "http://example.com/{?hoge,fuga}",
                                                                    hash_includes("hoge" => "fuga") ],
  ].each do |actual, matcher, *args|
    it_behaves_like "wildcard match", actual, matcher, *args
  end

  [ [ "http://example.com/hoge/fuga",  :with_uri_template, "http://example.com/hoge/{fuga}",   "fuga" => "hoge" ],
    [ "http://example.com/hoge/fuga",  :with_uri_template, "http://example.com/{hoge}/{fuga}", "hoge" => "fuga" ],
    [ "http://example.com/",           :with_uri_template, "http://example.com/{fuga}",        {} ],
    [ "http://example.com/?hoge=fuga", :with_uri_template, "http://example.com/{?hoge}",       "hoge" => "ugu" ],

    [ "http://example.com/?hoge=fuga&fuga=ugu", :with_uri_template, "http://example.com/{?hoge}",
                                                                    hash_includes("hoge" => "fuga") ],
  ].each do |actual, matcher, *args|
    it_behaves_like "not wildcard match", actual, matcher, *args
  end

  context "with without_query!", :focused do
    it "works" do
      wildcard_match?(
        "http://example.com/?hoge=fuga&fuga=ugu",
        with_uri_template("http://example.com/{?hoge}", hash_includes("hoge" => "fuga")).without_query!,
        &debugger
      ).should be_true
    end

    it "works" do
      wildcard_match?(
        "http://example.com/ugu?hoge=fuga&fuga=ugu",
        with_uri_template("http://example.com/{piyo}{?hoge}", hash_includes("hoge" => "fuga", "piyo" => "ugu")).without_query!,
        &debugger
      ).should be_true
    end
  end
end
