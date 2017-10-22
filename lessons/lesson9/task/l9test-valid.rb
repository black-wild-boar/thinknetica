require_relative ('./modules/l9validation.rb')

class A
  extend  Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor :name#, :type, :format

  def initialize(options={})
    @name = options[:name]
    # @type = options[:type]
    # @format = options[:format]
  end
end


p 'a test'
a = A.new
p a
a.name = 'qwe'
p a
a.validate!(:name, :presence)


 # p 'q2 class method test'
# q2 = A.new
# q2.methods
# q2.class.send(:validate_new)

# q2 = A.new(name: '')

# A.validate(q2, :name, :presence)
# A.validate(q2, :name, :format, '[a-z]', '.')
# A.validate(q2, :name, :type, 'InteGer')

# p 'q2 instance method test'
# q2.validate!(:name, :presence)
# q2.validate!(:name, :format, '[a-z]', '.')
# q2.validate!(:name, :type, 'Integer')


# p 'q3 class method test'
# q3 = A.new(name: 'asdf')

# A.validate(q3, :name, :presence)
# A.validate(q3, :name, :format, '[a-z]', '.')
# A.validate(q3, :name, :type, 'string')

# p 'q3 instance method test'
# q3.validate!(:name, :presence)
# q3.validate!(:name, :format, '[a-z]', '.')
# q3.validate!(:name, :type, 'IntEger')
