# class Foo
  
#   def initialize
#     @bar = 'Instance variable from initialize method of class Foo'
#   end

# private

#   def private_method
#     p "I'm a private method of class #{self.class}"
#   end
# end

module MyAttrAccessor
  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr1, :my_attr2, :my_attr3
end
