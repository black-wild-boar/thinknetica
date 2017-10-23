module Accessors

  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*names)
      names.each do | name |
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do | value |
          value_prev = [] << instance_variable_get(var_name)
          instance_variable_set("@#{name}_history".to_sym, value_prev << value)
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name.to_s.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do | value | 
        raise "Wrong value type. It must be #{class_name}" if !value.is_a?class_name
        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
    def attr_accessor_history(name)
      var_name = "@#{name}".to_sym
      values = instance_variable_get(var_name)
      p values
    end
  end
end

class Test
  include Accessors

  private
  attr_accessor_with_history :name, :surname
  strong_attr_accessor(:strong1, String)
end

t = Test.new
t.name = 5
t.name = 'str', :symbol
p t

t.attr_accessor_history(:name_history)

t.surname = 77
t.surname = 'abs'
p t

t.attr_accessor_history(:surname_history)

#false
t1= Test.new
p t1.methods
t1.strong1 = 55
p t1

#true
t2= Test.new
p t2.methods
t2.strong1 = 'str1'
p t2
