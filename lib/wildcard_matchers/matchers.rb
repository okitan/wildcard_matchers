module WildcardMatchers
  module Matchers
    def is_a(klass)
      klass
    end

    [ String, Integer, Float, Hash, Array ].each do |klass|
      module_eval %{
        def is_a_#{klass.to_s.downcase}
          #{klass.inspect}
        end
      }
    end

    def is_bool
      lambda {|bool| TrueClass === bool or FalseClass === bool }
    end

    def is_time
      lambda do |time|
        require "time"
        time.is_a?(Time) or (Time.parse(time) rescue nil)
      end
    end

    def hash_including(*args)
      lambda {|hash| (args - hash.keys).size > 0 }
    end
  end
end
