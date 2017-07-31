module Acessors

  def attr_accessor_with_history(*methods_name)
    methods_name.each do |method_name|
      variable_name = "@#{method_name}_history".to_sym
# define method setter with history
      history = []
      define_method("#{method_name}_history=".to_sym) do |value|
        instance_variable_set(variable_name, history << value)
      end
# define method getter with history
      define_method("#{method_name}_history".to_sym) {instance_variable_get(variable_name)}
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    variable_name = "@#{attr_name}".to_sym
    # define_method getter
    define_method(attr_name.to_sym) { instance_variable_get(variable_name) }
    # define method setter with check
    define_method("#{attr_name}=".to_sym) do |value|
      if value.class.to_s == attr_class
          instance_variable_set(variable_name, value)
      else
        raise ArgumentError, 'Argument is not the same class'
      end
    end
  end
end
