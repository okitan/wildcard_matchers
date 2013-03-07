require "facets/string/camelcase"

module WildcardMatchers
  module Matchers
    class << self
      def define_wildcard_matcher(name, &block)
        if block_given?
          define_method(name, &block)
        else
          define_method(name) do |*args|
            ::WildcardMatchers::Matchers.const_get(name.to_s.camelcase(:upper)).new(args)
          end
        end
      end

      def define_wildcard_matcher_with_proc(name, &block)
        raise "no block defined" unless block_given?

        define_method(name) do
          block
        end
      end
    end

    # is_a(klass)
    define_wildcard_matcher(:is_a) do |klass|
      klass
    end

    # is_a_string
    # is_a_integer
    # is_a_float
    # is_a_hash
    # is_a_array
    [ String, Integer, Float, Hash, Array ].each do |klass|
      define_wildcard_matcher("is_a_#{klass.to_s.downcase}") do
        klass
      end
    end

    # is_bool
    define_wildcard_matcher_with_proc(:is_bool) do |bool|
      TrueClass === bool or FalseClass === bool
    end

    # is_time
    define_wildcard_matcher_with_proc(:is_time) do |time|
      require "time"
      time.is_a?(Time) or (Time.parse(time) rescue false)
    end

    # TODO: DSL
    def is_a_member_of(*args)
      lambda do |item|
        args.flatten.any? {|expected| expected === item }
      end
    end
  end
end

require "wildcard_matchers/matchers/hash_includes"
require "wildcard_matchers/matchers/is_uri"
require "wildcard_matchers/matchers/with_uri_template"
