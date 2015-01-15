# Must be initialized with a set_of promotions
class Checkout
  attr_reader :basket, :rules_set
  def initialize(promotions_set)
    @basket = []
    @rules_set = promotions_set
  end

  def rules
    @rules_set.rules
  end

  def scan(product)
    basket << product
  end

  def sub_total
    @rules_set.basket = basket
    @rules_set.apply_product_discounts
    @rules_set.amount = @rules_set.calculate_amount
  end

  def total
    sub_total
    "£#{@rules_set.apply_price_discounts.round(2)}"
  end

end
