# Provides the functionality for all classes for adding promotions
module Promotional

  attr_accessor :amount, :basket

  def calculate_total(basket)
    self.basket = basket
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
    price_rules.each { |rule| self.send("#{rule}") }
  end

  def apply_product_discounts
    product_rules.each { |rule| self.send(rule.to_sym) }
  end

  #selects rules with price in the name
  def price_rules
    rules.select { |rule| rule.to_s.include?('price') }
  end

  #selects rules with product in the name
  def product_rules
    rules.select { |rule| rule.to_s.include?('product') }
  end

  # gathers methods ending in 'rule'
  def rules
    singleton_methods.select { |method| method.to_s.split(//).last(4).join == 'rule' }
  end

end
