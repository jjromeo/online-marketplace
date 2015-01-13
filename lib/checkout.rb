class Checkout
  attr_reader :products, :rules_set
  def initialize(promotional_rule_checker)
    @products = []
    @rules_set = promotional_rule_checker
  end

  def rules
    @rules_set.rules
  end

  def scan(product)
    products << product
  end

  def sub_total
    discounted_products = apply_product_discounts(products)
    @rules_set.amount = discounted_products.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
  end

  def total
    sub_total
    apply_price_discounts
  end

  def apply_price_discounts
    @rules_set.price_rules.each { |rule| @rules_set.send("#{rule}") }
    @rules_set.amount
  end

  def apply_product_discounts(products)
    @rules_set.product_rules.each { |rule| @rules_set.send(rule.to_sym, products) }
    products
  end
end
