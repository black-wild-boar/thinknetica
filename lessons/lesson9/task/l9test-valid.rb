require_relative ('./modules/l9validation.rb')

class A
  extend  Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor :name, :name1, :type, :format

  def initialize(options={})
    @name = options[:name]
    @name1 = options[:name1]
    @type = options[:type]
    @format = options[:format]
  end
end

p 'b instance of class A'
b = A.new
b.name1 = 'qwe'
b.validate!(:name1, :presence)
b.validate!(:name1, :format, '.')
b.validate!(:name1, :type, String)

p 'a instance of class A'
a = A.new
a.name = ''
a.validate!(:name, :presence)
a.validate!(:name, :format, '.')
a.validate!(:name, :type, String)
