module Validation
  module ClassMethods

    # CHECKS = { validate_presence: ->(name) { validate_presence(name) },
    #           format: ->(name, format) { format(name, format) },
    #           type: ->(name, type) { type(name ,type)} }

    CHECKS = { presence: proc {|name| validate_presence(name) },
              format: proc { |name, format| validate_format(name, format) },
              type: proc { |name, type| validate_type(name ,type)}
            }

    def validate_new(check_attr, check_type, attrs)
      p 'class method validate_new'
      
      p "check_attr #{check_attr}"
      p "check_type #{check_type}"


      CHECKS[check_type].call(check_attr)

      # p self
      # p instance_variables
      # @@checks[attrs[:validate_type]].call
      # obj, name, check_type, *attrs)    
    end

    def validate(obj, name, check_type, *attrs)
      # где правильнее вычислять значение: в публичном или приватном методе?
      # с точки зрения сокрытия деталей реализации - в приватном, но тогда приходится постоянно переносить объект как параметр метода
      name = obj.instance_variable_get("@#{name}".to_sym)
      if attrs.empty?
        # CHECKS[check_type].call(name)
        validate_presence(name) if check_type == :validate_presence
      else
        attrs.each do | attr |
          format(name, attr) if check_type == :format
          type(name, attr) if check_type == :type
          # attrs.each(&:CHECKS[check_type].call(name, attr))        
        end
      end

      rescue
      p "Checking complite! You have some errors! #{false}"

    end


    def valid?(obj, name, check_type, *attrs)
      validate(obj, name, check_type, *attrs)
    rescue
      p 'Validate error'
      p false
    end

 # private 

    def validate_presence(name)
      p 'Check validate_presence...'
      p name
      # почему не работает вариант с тернарными операторами?
      # valid? ? !(value.nil? || value == '') : !valid?
      
      raise if name.nil? || name == ''
      p 'No validate_presence error'
      rescue
      p "validate_presence validation error! #{false}"

      # p valid?
      # true
      
      # if !(name.nil? || name == '')
      #   valid?
      # else
      #   !valid?
      # end
      
    end

    def validate_format(name, format)# = /^[A-Z]{0,3}$/)
      p 'Check validate_format...'
      format = Regexp.new "#{format}"
      
      raise 'Format validation error!' if name !~ format
      p 'No format error'
      rescue
      p "Format validation error! #{false}"
    end

    def validate_type(name ,type)
      p 'Check validate_type'
      raise 'Type validateion error' if name.class.to_s != type.to_s.capitalize
      p 'No type error'
      rescue
      p "Type validation error! #{false}"
    end
  end

  module InstanceMethods
    def validate!(check_attr, check_type, *attrs)
      # self.class.valid?(obj = self, name, check_type, *attrs)
      p 'instance method validate!'
      p "check_attr #{check_attr}"
      p "check_attr value #{instance_variable_get("@#{check_attr}".to_sym)}"

      p "check_type #{check_type}"
      check_attr = instance_variable_get("@#{check_attr}".to_sym)
p "check_attr #{check_attr}"

      self.class.send(:validate_new, check_attr, check_type, attrs)
    end

      def validate_presence(name)
      p 'Check validate_presence...'
      p name
      end
  end
end