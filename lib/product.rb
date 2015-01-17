class Product
  attr_accessor :code, :name, :price

  ATTRS = [:code, :name, :price]

  def initialize(attributes = {})
    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
    validate_attrs
  end

  private
  def validate_attrs
    ATTRS.each do |attr| 
      raise "Error: Missing #{attr} attribute" unless instance_variable_get("@#{attr}") 
    end
  end

end
