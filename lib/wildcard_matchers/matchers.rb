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
  end
end
