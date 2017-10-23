module Validation
  module ClassMethods

    # CHECKS = { validate_presence: ->(name) { validate_presence(name) },
    #           format: ->(name, format) { format(name, format) },
    #           type: ->(name, type) { type(name ,type)} }

    # CHECKS = { presence: proc {|name| validate_presence(name) },
            #   format: proc { |name, format| validate_format(name, format) },
            #   type: proc { |name, type| validate_type(name ,type)}
            # }

    def validate(check_attr, check_type, *attrs)
      p 'class method validate'
      
      # var_name = "@@checks".to_sym
      # value  = { presence: proc {|check_attr| validate_presence(check_attr) },
      #           format: proc { |check_attr, attrs| validate_format(check_attr, attrs) },
      #           type: proc { |check_attr, attrs| validate_type(check_attr ,attrs)}
      #         }
      #   class_variable_set(var_name, value)

      # p "class_variables #{class_variables}"

      var_name = "@@#{check_type}".to_sym
      value = {name: check_attr, attrs: attrs}
      
      # p "class_variable_set"
      class_variable_set(var_name, value)

      # p "class_variables #{class_variables}"
      # p class_variable_get(var_name)
    end
  end

  module InstanceMethods
    def validate!(check_attr, check_type, *attrs)
      p 'instance method validate!'
  
      # self.class.send(:validate, check_attr, check_type, *attrs)
      # self.class.send(:validate, class_variable_get(:@@checks)[check_type].call)

      check_attr = instance_variable_get("@#{check_attr}".to_sym)
      #сохраняем правила валидации
      self.class.send(:validate, check_attr, check_type, attrs)
  
      if attrs.empty?
        self.send("validate_#{check_type}".to_sym, check_attr)
      else
        self.send("validate_#{check_type}".to_sym, check_attr, attrs)
      end
    end

  private

    def validate_presence(name)
      p 'Check validate_presence...'
      raise 'Presence validation error!' if name.nil? || name == ''
        p "No validate_presence error #{valid?}"
    rescue
        p "Validate_presence validation error! #{!valid?}"
    end

    def validate_format(name, format)
      p 'Check validate_format...'
      format = Regexp.new "#{format}"
      raise 'Format validation error!' if name !~ format
      p "No format error #{valid?}"
    rescue
      p "Format validation error! #{!valid?}"
    end

    def validate_type(name ,type)
      p 'Check validate_type'
      raise 'Type validation error' if !name.is_a?type[0]
      p "No type error #{valid?}"
    rescue
      p "Type validation error! #{!valid?}"
    end

    def valid?
      return true
    end
  end
end