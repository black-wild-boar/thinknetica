module Validation
  
  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(check_attr, check_type, *attrs)
      p 'Save check rules invoke from class'

      instance_var = "@#{check_attr}".to_sym
      class_var = "@@#{check_attr}".to_sym

      check_type = check_type
      attrs = attrs
      # p "0class_variables = #{class_variables}"
      rule = {check_attr => { check_type => attrs } }
      # p "rule = #{rule}"

      if !class_variable_defined?(class_var)
        # If no rules exist
        # p class_var
        class_variable_set(class_var, rule)
      else
        # If at least one rule exist
        # p "1class_variables = #{class_variables}"
        rule_prev = class_variable_get(class_var)
        # p "rule_prev = #{rule_prev}"
        rule_prev[check_attr].merge!(rule[check_attr])
        rules = rule_prev
        class_variable_set(class_var, rules)
      end
    end
  end

  module InstanceMethods
    def validate!
      p 'Instance method validate!'
      # p "instance_variables = #{instance_variables}"
      class_vars = self.class.class_variables
      # p "class_vars = #{class_vars}"
      instance_vars = instance_variables
      # p "instance_vars = #{instance_vars}"

      #  Getting variables only for exist rules
      class_vars2instance_vars = class_vars.map! {|class_var| "#{class_var}".sub(/[@]/, '').to_sym}
      # p "class_vars2instance_vars = #{class_vars2instance_vars} "
      instance_vars.delete_if { | var_name | !class_vars2instance_vars.include?(var_name) }
      # p "2instance_vars = #{instance_vars}"

      instance_vars.each do | var_name |
        p "==== Check = #{var_name} = value ===="

        class_var_name = "@#{var_name}".to_sym
        # p "class_var_name = #{class_var_name}"
        # p "2var_name = #{var_name}"
        rule_var_name = "#{var_name}".delete('@').to_sym
        rule = self.class.class_variable_get(class_var_name).fetch(rule_var_name)
        # p "rule = #{rule} "
        rule.select do | check_method, attrs |
          check_method = "validate_#{check_method}"
          # p "check_method = #{check_method}"
          # p "var_name = #{var_name}"
          instance_value = instance_variable_get(var_name)
          # p "instance_value = #{instance_value}"
          self.send(check_method, instance_value, attrs)
        end #rules    
      end #var_names
    end

  private

    def validate_presence(name, attr=nil)
      p 'Check validate_presence...'
      raise 'Presence validation error!' if name.nil? || name == ''
        p "No presence error: #{valid?}"
    rescue
        p "Presence validation error! #{!valid?}"
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
  include Validation

  attr_accessor :name, :name1, :name3

  validate :name1, :presence
  validate :name1, :type, String
  validate :name, :type, Integer
  validate :name, :presence
  validate :name1, :format, /[A-Z]/

end

p 'Variable b contains an instance of class Test. Check attributes :name1 && :name with rules invoke from class'
t = Test.new
t.name1 = 'DD'
t.name = ''
p t 
t.name3 = 333
t.validate!
