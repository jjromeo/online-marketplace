require 'byebug'
#applies discounts to basket
class Discounter
  attr_accessor :amount, :basket
  attr_reader :rules

  def initialize(*rules)
    @rules = rules
  end

  def calculate_total(new_basket)
    @basket = new_basket
    apply_product_discounts
    calculate_amount
    apply_price_discounts
    amount.round(2)
  end

  private

  def calculate_amount
    self.amount = basket.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
    amount
  end

  def apply_price_discounts
    price_rules.each { |rule| self.amount = rule.apply(amount) }
  end

  def apply_product_discounts
    product_rules.each { |rule| self.basket = rule.apply(basket) }
  end

  def price_rules
    rules.select { |rule| rule.type == :price }
  end

  def product_rules
    rules.select { |rule| rule.type == :product }
  end


end
