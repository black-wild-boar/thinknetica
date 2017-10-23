module Validation
  module ClassMethods
    def validate(check_attr, check_type, *attrs)
      p 'Class method validate'
      #сохраняем правила валидации
      # @validate_rules = { check_attr: {presence: attrs,format: attrs, type: attrs} }
            
      value = {name: check_attr, attrs: attrs}
      var_name = "@#{check_type}".to_sym
      
      instance_variable_set(var_name, value)
      p '7777'
      # p instance_variables
      # p var_name
      # p instance_variable_get(var_name)

    end
  end

  module InstanceMethods
    def validate!(check_attr, check_type, *attrs)
      p 'Instance method validate!'
      # check_attr = instance_variable_get("@#{check_attr}".to_sym)
      # self.send("validate_#{check_type}".to_sym, check_attr, attrs)
      p '555555'
      # p self
      # p check_type
      # p instance_variable_get("@#{check_attr}".to_sym)
      #from validate scheme
      check_hash_value = self.class.instance_variable_get("@#{check_type}".to_sym)
      p check_hash_value
      p check_hash_value.class
      p check_hash_value.keys
      #from validate scheme
      check_attr = check_hash_value[:name]
      p check_attr
      attrs = check_hash_value[:attrs]
      p attrs
      self.send("validate_#{check_type}".to_sym, check_attr, attrs)
    end

  private

    def validate_presence(name, attr_nil=nil)
      p 'Check validate_presence...'
      raise 'Presence validation error!' if name.nil? || name == ''
        p "No validate_presence error: #{valid?}"
    rescue
        p "Validate_presence validation error! #{!valid?}"
    end

    def validate_format(name, format)
      p 'Check validate_format...'
      format = Regexp.new(format[0])
      raise 'Format validation error!' if name !~ format
      p "No format error: #{valid?}"
    rescue
      p "Format validation error! #{!valid?}"
    end

    def validate_type(name ,type)
      p 'Check validate_type'
      raise 'Type validation error' if !name.is_a?type[0]
      p "No type error: #{valid?}"
    rescue
      p "Type validation error! #{!valid?}"
    end

    def valid?
      return true
    end
  end
end

class Test
  extend  Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor :name, :name1

  validate :name1, :presence
  validate :name1, :format, /[A-Z]/
  validate :name1, :type, String
end

p 'b instance of class A. check_attr :name1'
b = Test.new
b.name1 = 'DD'
p b 
b.validate!(:name1, :presence)
# b.validate!(:name1, :format, /[A-Z]/)
# b.validate!(:name1, :type, String)

# p 'b instance of class A. check_attr :name'
# b.name = ''
# p b
# b.validate!(:name, :presence)
# b.validate!(:name, :format, /a-z/)
# b.validate!(:name, :type, Integer)
