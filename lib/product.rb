class Product
  attr_accessor :code, :name, :price

  def initialize(attributes = {})
    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
    raise 'Error: Missing an attribute' unless @code && @name && @price
  end

  def validate_attrs

  end

  def validate_price
  end
end
