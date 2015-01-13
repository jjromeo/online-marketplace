class Checkout
  attr_reader :products
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
    discounted_products = @rules_set.two_lavender_hearts_product_rule(products)
    discounted_products.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
  end

  def total
    @rules_set.over_60_pounds_price_rule(sub_total)
  end

end
