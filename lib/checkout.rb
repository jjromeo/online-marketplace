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
    "#{@rules_set.calculate_total(basket)}"
  end


end
