require_relative 'promotion.rb'
# Example product rule
class MultipleItemPromotion < Promotion
  attr_reader :product_name, :required_quantity, :new_price
  def initialize(options = {})
    set_type_to_product
    @product_name = options[:product_name]
    @required_quantity = options[:required_quantity]
    @new_price = options[:new_price]
  end

  def apply(basket)
    sufficient_quantity?(basket) ? reprice_products(basket) : basket
  end

  private

  def sufficient_quantity?(basket)
    relevant_products = basket.select { |product| relevant_product?(product) }
    relevant_products.count >= required_quantity
  end

  def relevant_product?(product)
    product.name == product_name
  end

  def reprice_products(basket)
    basket.each { |product| product.price = '£8.50' if relevant_product?(product)}
  end
end
