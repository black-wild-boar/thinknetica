module Validation
  module ClassMethods

    # CHECKS = { presence: ->(name) { presence(name) },
    #           format: ->(name, format) { format(name, format) },
    #           type: ->(name, type) { type(name ,type)} }

    def validate(obj, name, check_type, *attrs)
      # где правильнее вычислять значение: в публичном или приватном методе?
      # с точки зрения сокрытия деталей реализации - в приватном, но тогда приходится постоянно переносить объект как параметр метода
      name = obj.instance_variable_get("@#{name}".to_sym)
      if attrs.empty?
        # CHECKS[check_type].call(name)
        presence(name) if check_type == :presence
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

 private 

    def presence(name)
      p 'Check presence...'
      # почему не работает вариант с тернарными операторами?
      # valid? ? !(value.nil? || value == '') : !valid?
      
      raise if name.nil? || name == ''
      p 'No presence error'
      rescue
      p "Presence validation error! #{false}"

      # p valid?
      # true
      
      # if !(name.nil? || name == '')
      #   valid?
      # else
      #   !valid?
      # end
      
    end

    def format(name, format)# = /^[A-Z]{0,3}$/)
      p 'Check format...'
      format = Regexp.new "#{format}"
      
      raise 'Format validation error!' if name !~ format
      p 'No format error'
      rescue
      p "Format validation error! #{false}"
    end

    def type(name ,type)
      p 'Check type'
      raise 'Type validateion error' if name.class.to_s != type.to_s.capitalize
      p 'No type error'
      rescue
      p "Type validation error! #{false}"
    end
  end

  module InstanceMethods
    def validate!(name, check_type, *attrs)
      self.class.valid?(obj = self, name, check_type, *attrs)
    end
  end
end