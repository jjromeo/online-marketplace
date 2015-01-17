class Product

  #ATTRS constant will control which attrs a product must be initialized with
  ATTRS = [:code, :name, :price]

  def initialize(attributes = {})
    set_attrs(attributes)
    validate_attrs
  end

  private

  #Sets instance variable for each attribute to its value in attributes hash 
  #Creates an attr_accessor for that attribute
  def set_attrs(attributes)
    ATTRS.each do |attr| 
      instance_variable_set("@#{attr}", attributes[attr])
      self.class.send(:attr_accessor, attr)
    end
  end

  #Checks all attributes are accounted for
  def validate_attrs
    ATTRS.each do |attr| 
      raise "Error: Missing #{attr} attribute" unless instance_variable_get("@#{attr}") 
    end
  end

end
