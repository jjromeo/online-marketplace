#Contains information for each product
class Product

  ATTRS = [:code, :name, :price]

  def initialize(attributes = {})
    set_attrs(attributes)
    validate_attrs
  end

  private

  def set_attrs(attributes)
    ATTRS.each do |attr| 
      instance_variable_set("@#{attr}", attributes[attr])
      self.class.send(:attr_accessor, attr)
    end
  end

  def validate_attrs
    ATTRS.each do |attr| 
      raise "Error: Missing #{attr} attribute" unless instance_variable_get("@#{attr}") 
    end
  end

end
