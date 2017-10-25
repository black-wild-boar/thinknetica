module Validation
  module ClassMethods
    def validate(check_attr, check_type, *attrs)
      p 'Save check rules invoke from class'

      var_name = "@#{check_attr}".to_sym
      check_attr_key = "#{check_attr}".to_sym
      
      check_type = "#{check_type}".to_sym
      value = [ { check_type => attrs } ]

      if instance_variable_get(var_name).nil?
        instance_variable_set(var_name, [] << value)
      else
        value_prev = instance_variable_get(var_name)
        instance_variable_set(var_name, value_prev << value)
      end

      vars = instance_variables
      vars.each do | var |
        p "var = #{var} "
        p instance_variable_get(var)
      end
    end
  end

  module InstanceMethods
    def validate!
      p 'Instance method validate!'
      local_vars = instance_variables
      class_inst_var = self.class.send(:instance_variables)

      local_vars.each do | local_var |
        p "==== Validate for #{local_var} ===="
        local_var_value = instance_variable_get(local_var)
        check_rules = self.class.send(:instance_variable_get, local_var)
        check_rules.each do | rule |
          p "rule = #{rule}"
            rule.each do | rule_hash |
              rule_hash.select do | check_type, attrs |
                validate_method = "validate_#{check_type}".to_sym
                self.send(validate_method, local_var_value, attrs)
              end
            end
        end
      end
    end

  private

    def validate_presence(name, attr=nil)
      p 'Check validate_presence...'
      raise 'Presence validation error!' if name.nil? || name == ''
        p "No validate_presence error: #{valid?}"
    rescue
        p "Validate_presence validation error! #{!valid?}"
    end

    def validate_format(name, attr)
      p 'Check validate_format...'
      attr = Regexp.new(attr[0])
      raise 'Format validation error!' if name.to_s !~ attr
      p "No format error: #{valid?}"
    rescue
      p "Format validation error! #{!valid?}"
    end

    def validate_type(name ,attr)
      p 'Check validate_type'
      raise 'Type validation error' if !name.is_a?attr[0]
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
  validate :name1, :type, String
  validate :name, :type, Integer
  validate :name, :presence
  validate :name1, :format, /[A-Z]/

end

p 'Variable b contains an instance of class Test. Check attributes :name1 && :name with rules invoke from class'
t = Test.new
t.name1 = 'DD'
t.name = '3'
p t 
t.validate!
