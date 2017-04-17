module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def instances
      puts "Количество единиц #{self.class}: #{@instance_counter}"
    end
  end
  module InstanceMethods
    protected
    def register_instance
      @instance_counter += 1
    end
    #def print_class
    #  puts self.class
    #end
  end
end
end