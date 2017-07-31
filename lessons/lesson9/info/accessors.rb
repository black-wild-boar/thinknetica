# Написать модуль Acessors, содержащий следующие методы, которые можно вызывать на
# уровне класса:

# метод   
# attr_accessor_with_history
 
#  Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
# при этом сеттер сохраняет все значения инстанс-переменной при изменении этого
# значения.  Также в класс, в который подключается модуль должен добавляться
# инстанс-метод   <имя_атрибута>_history
 
#   который возвращает массив всех значений данной переменной.

# метод  
# strong_attr_acessor
 
#  который принимает имя атрибута и его класс. При этом создается геттер и
# сеттер для одноименной инстанс-переменной, но сеттер проверяет тип
# присваемоего значения. Если тип отличается от того, который указан вторым
# параметром, то выбрасывается исключение. Если тип совпадает, то значение
# присваивается. 

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

# class CreateAcessor
#   extend Acessors

#   # def add(name)
#   @@methods = []
#   def initialize#(name)
#     @@methods << self
#   end

#   def method_missing(method_name)
    
#   end

#   def add_accessor
#    loop do
#      p 'enter method name'
#      method_name = gets.chomp.to_sym
#     if method_name == :exit
#       puts @methods.inspect    
#       break 
#     end
#     attr_accessor_with_history method_name

#     # attr_accessor_with_history name
#    end
#    end
# end

# #p 'print'
# #n = gets.chomp
# #n = CreateAcessor.new
# #p n.public_methods
# #n.add('m1')
# #p n

# #c1.public_methods
# #c1.instance_variables