module Validation
  
  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods
 
    def validate(check_attr, check_type, attr = nil)
      p 'Save check rules invoke from class'

      @validate_rules ||= {}
      @validate_rules[check_type] ||= {}
      @validate_rules[check_type][check_attr] ||= []
      @validate_rules[check_type][check_attr] << attr
    end

    def validate_rules
      return @validate_rules
    end
  end

  module InstanceMethods
    def validate!
      p 'Instance method validate!'

      all_rules = self.class.send(:validate_rules)
      local_vars = instance_variables.map! { | var | var.to_s.delete('@') }
      rules_vars = all_rules.values[0].keys.map(&:to_s) 
      local_vars_with_rules = (local_vars & rules_vars).map!(&:to_sym)
      local_vars_with_rules.each do | exist_var |
        value = instance_variable_get("@#{exist_var}".to_sym)
        all_rules.each_pair do | check_key, check_value |
          check_value.each_pair do | var_name, attr |
            if var_name == exist_var
              send("validate_#{check_key}".to_sym, value, attr[0])
            else
              p "No rule for local Variable #{exist_var}"
            end
          end
        end
      end
    end

  private

    def validate_presence(name, attr)
      p 'Check validate_presence...'
      raise 'Presence validation error!' if name.nil? || name == ''
        p "No presence error: #{valid?}"
    rescue
        p "Presence validation error! #{!valid?}"
    end

    def validate_format(name, attr)
      p 'Check validate_format...'
      attr = Regexp.new(attr)
      raise 'Format validation error!' if name.to_s !~ attr
      p "No format error: #{valid?}"
    rescue
      p "Format validation error! #{!valid?}"
    end

    def validate_type(name ,attr)
      p 'Check validate_type'
      raise 'Type validation error' if !name.is_a?attr
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
t.name1 = 0
# t.name = 'EE'
p t 
t.name3 = 333
t.validate!
