class Product
  attr_accessor :code, :name, :price

  def initialize(attributes = {})
    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
    validate_attrs
  end

  private
  def validate_attrs
    validate_price
    validate_name
    validate_code
  end

  def validate_price
    raise 'Error: Missing price attribute' unless @price
  end

  def validate_name
    raise 'Error: Missing name attribute' unless @name
  end

  def validate_code
    raise 'Error: Missing code attribute' unless @code
  end
end
