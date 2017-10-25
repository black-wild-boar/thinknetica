module Validation
  module ClassMethods
    def validate(check_attr, check_type, *attrs)
      p 'Save check rules invoke from class'

      # main_hash = {check_attr: {presence: *attrs, type: *attrs, format: *attrs} }
      # т.к. может быть несколько разных проверок на инстанс переменной


                # var_name = "@#{check_attr}".to_sym
                # value = {check_type: check_type, attrs: attrs}
                
                # # p "value #{value}"
                # if instance_variable_get(var_name).nil?
                #   instance_variable_set(var_name, value)
                #  else
                #    value_prev = instance_variable_get(var_name)
                #    # p "value_prev = #{value_prev}"
                #    instance_variable_set(var_name, value_prev << value)
                # end

      # var_name = "@#{check_attr}".to_sym

      # value_prev = [] << instance_variable_get(var_name)

      # value = {check_type: check_type, attrs: attrs}

      # instance_variable_set(var_name, value_prev << value)
      
 
 # p "instance_variables #{instance_variables}"
 # p "instance_variable_get(:@name) #{instance_variable_get(:@name)}"
 # p "instance_variable_get(:@name1) #{instance_variable_get(:@name1)}"


    var_name = "@#{check_attr}".to_sym
    p "var_name = #{var_name}"
    # value = [] << {"#{check_attr}": {check_type: check_type, attrs: attrs}}
    
    check_attr_key = "#{check_attr}".to_sym
    
    check_type = "#{check_type}".to_sym

    # value = [ check_attr_key =>  { check_type => [attrs] } ]
    value = [ { check_type => [attrs] } ]
# value = { check_attr_key => [ { check_type => [attrs] } ] }

    p "value = #{value}"
    
# checktype_and_attr_by_key = value[check_attr_key]

# p "checktype_and_attr_by_key = #{checktype_and_attr_by_key}"

# attr_by_key_and_checktype = checktype_and_attr_by_key[check_type]

# p "attr_by_key_and_checktype = #{attr_by_key_and_checktype}"
  p "instance_variable_get(var_name) = #{instance_variable_get(var_name)}"

    if instance_variable_get(var_name).nil?
      instance_variable_set(var_name, value)
    else
      value_prev = instance_variable_get(var_name)
      # p "222value_prev = #{value_prev}"
#       attr_value_prev = value_prev[check_attr_key][check_type] || [nil]
#       p "222attr_value_prev = #{attr_value_prev}"
#       attr_value = value[check_attr_key][check_type || nil]
#       p "222attr_value = #{attr_value}"
#       new_attr = attr_value_prev << attr_value
#       p "new_attr = #{new_attr}"

# #new attr value
#       # value = value_prev << value

#       value[check_attr_key][check_type] = [new_attr]
# p "222value = #{value}"

    # value[check_attr_key] = value_prev[check_attr_key] << value[check_attr_key]
    #   p "222v = #{value}"

    v_p = value_prev#[check_attr_key][check_type] || [nil]
    p "222v_p = #{v_p}"
    v = value#[check_attr_key][check_type] || [nil]
    p "222v = #{v}"
    # p value[check_attr_key][check_type].class if check_type == :format

# value[check_attr_key][check_type] = v_p << v
    # p "222value = #{value}"

      instance_variable_set(var_name, v_p << v)
    end


    p "222instance_variables = #{instance_variables}"

    vars = instance_variables #{instance_variables}
    vars.each do | var |
      p "var = #{var} "
      p instance_variable_get(var)
    end

#     # p "value[to_sym] = #{value["#{check_attr}".to_sym]}"
#     p value.fetch("#{check_attr}".to_sym)
    
#     if !instance_variable_get(var_name).nil?
#       global_scope = instance_variable_get(var_name)

#     p "value = #{value}"
#     p "value[to_sym] = #{value["#{check_attr}".to_sym]}"
#     p value.fetch("#{check_attr}".to_sym)


#       p "global_scope = #{global_scope}"

# p "global_scope = #{global_scope["#{check_attr}".to_sym]}"
#       global_scope = "#{global_scope["#{check_attr}".to_sym]}"
#       p "global_scope = #{global_scope}"
#       value = "#{value["#{check_attr}".to_sym]}"
#     p "value = #{value}"

#       instance_variable_set(var_name, global_scope << value)
#     else
#       # run one first time
#       instance_variable_set(var_name, value)
#     end

    end
  end

  module InstanceMethods
    def validate!
      p 'Instance method validate!'
      check_attr = self.class.send(:instance_variables)
p '5555'
      p check_attr
      # p self.class.send(:instance_variable_get, :@name)
      # p self.class.send(:instance_variable_get(:@name1))

      check_attr.each do | key |
        p 'each'
        p key
        # check_type = key.to_s.delete('@')
        check_attr_key = self.class.send(:instance_variable_get, key)#[:check_type]
        p check_attr_key
        # check_attr_key = self.class.send(:instance_variable_get, key)[:check_type]
        # p check_attr_key
        # check_attr = instance_variable_get(key)
        # p check_attr

      end


#       check_attr.each do | key |
#         check_type = key.to_s.delete('@')
#         check_attr_key = self.class.send(:instance_variable_get, key)[:check_attr]
#         check_attr = instance_variable_get("@#{check_attr_key}".to_sym)
# p check_attr
#         attrs = self.class.send(:instance_variable_get, key)[:attrs]
#         self.send("validate_#{check_type}".to_sym, check_attr, attrs)
#       end
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
      raise 'Format validation error!' if name !~ attr
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
  # validate :name, :type, Integer
  validate :name, :presence
  validate :name1, :format, /[A-Z]/

end

# p 'Variable b contains an instance of class Test. Check attributes :name1 && :name with rules invoke from class'
# b = Test.new
# b.name1 = 'DD'
# b.name = 5
# p b 
# b.validate!
