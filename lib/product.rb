class Product
  attr_accessor :code, :name, :price

  def initialize(attributes = {})
    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
  end

end
