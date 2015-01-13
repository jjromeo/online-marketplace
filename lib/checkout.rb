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
    discounted_basket = apply_product_discounts(basket)
    @rules_set.amount = discounted_basket.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
  end

  def total
    sub_total
    "£#{apply_price_discounts.round(2)}"
  end

  def apply_price_discounts
    @rules_set.price_rules.each { |rule| @rules_set.send("#{rule}") }
    @rules_set.amount
  end

  def apply_product_discounts(basket)
    @rules_set.product_rules.each { |rule| @rules_set.send(rule.to_sym, basket) }
    basket
  end
end
