# class Foo
#   def initialize
#     @bar = "instance variable"
#   end

#   private
  
#   def private_method
#     puts "I'm private method"
#   end
# end

# foo = Foo.new
# p foo.instance_eval('@bar')
# foo.instance_eval('private_method')

# foo.instance_eval do
#   p 'instance_eval get block'
#   p foo.instance_eval('@bar')
#   foo.instance_eval('private_method')
# end

# foo.instance_eval do
#   def m
#     p 'instance_eval get block with method'
#     p @bar
#     p private_method
#   end
# end

# foo.m

module MyAttrAccessor
  def my_attr_accessor(*names) # * ==array arguments
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr, :a, :b, :c
end