# super class for promotions
class Promotion
  attr_reader :type

  def apply
    fail 'this promotion has no effect please override the #apply method'
  end

  def set_type_to_product
    @type = :product
  end

  def set_type_to_price
    @type = :price
  end
end
