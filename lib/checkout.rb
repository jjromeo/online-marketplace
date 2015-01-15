# Must be initialized with a set_of promotions
class Checkout
  attr_reader :basket, :rules_set
  def initialize(promotions_set)
    @basket = []
    @rules_set = promotions_set
  end

  def scan(product)
    basket << product
  end

  def total
    submit_basket
    "#{@rules_set.apply_discounts.round(2)}"
  end

  def submit_basket
    @rules_set.basket = basket
  end

end
