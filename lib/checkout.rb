class Checkout
  attr_reader :products
  def initialize(promotional_rules_set)
    @products = []
    @rules_set = promotional_rules_set
  end

  def rules
    @rules_set.rules
  end

  def scan(product)
    products << product
  end

  def total
    float_total = products.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
    "£#{float_total}"
  end

end
