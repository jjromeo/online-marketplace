# Takes in products and totals them
class Checkout
  attr_reader :basket, :discounter

  def initialize(discounter)
    @basket = []
    @discounter = discounter
  end

  def scan(product)
    basket << product
  end

  def total
    "£#{discounter.calculate_total(basket)}"
  end
end
