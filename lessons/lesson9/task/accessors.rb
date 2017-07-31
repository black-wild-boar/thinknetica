module Validation
# Написать модуль Validation, который:
def validate(name_check, type, *args)
  case type do
  when '-presence'
  when '-format'
  when '-type'
  else
    p 'Wrong validate type'
  end
end
# Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута,
# а также тип валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
# - presence - требует, чтобы значение атрибута было не nil и не пустой строкой. 

# Пример использования:  

# validate :name, :presence

# - format (при этом отдельным параметром задается регулярное выражение для формата). 
# Треубет соответствия значения атрибута заданному регулярному выражению. 

# Пример:  

# validate :number, :format, /A-Z{0,3}/

# - type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу. 

# Пример:  

# validate :station, :type, RailwayStation

# Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса validate.
# В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, 

# например

# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String

# Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.


# Подключить эти модули в свои классы и продемонстрировать их использование.
# Валидации заменить на методы из модуля Validation. 

end#module Validation

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
