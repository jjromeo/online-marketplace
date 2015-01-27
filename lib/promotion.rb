#super class for rules
class Promotion
  attr_reader :type

  #override as method for applying discount
  def apply
    raise 'this promotion has no effect please override the #apply method'
  end

  #call in initialize for promotions affecting specific products
  def set_type_to_product
    @type = :product
  end

  #call in initialize for promotions affecting total price
  def set_type_to_price
    @type = :price
  end

end
