module Accessors

  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*names)
      calculate = []
      names.each do | name |
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do | value |
          instance_variable_set(var_name, value) 
          instance_variable_set("@#{name}_history".to_sym, calculate << value)
        end
      end
    end
  end

  module InstanceMethods

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      self.class.send(:define_method, name, ->() { instance_variable_get(var_name) } )
      self.class.send(:define_method, "#{name}=".to_sym, ->(value) do 
        class_name = class_name.to_s.strip.capitalize
        if value.class.to_s != class_name
          raise ArgumentError, "Wrong value type. It must be #{class_name}" 
        else
          instance_variable_set(var_name, value)
        end
      end
      ) # как поправить такой синтаксис? или это нормально?
    end
  end
end

class Test
  include Accessors

  private
  def method_missing(name)
    self.class.attr_accessor_with_history(name)
  end
end

