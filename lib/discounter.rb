# applies discounts to basket
class Discounter
  attr_accessor :amount, :basket
  attr_reader :promotions

  def initialize(*promotions)
    @promotions = promotions
  end

  def calculate_total(new_basket)
    @basket = new_basket
    apply_product_discounts
    calculate_amount
    apply_price_discounts
    amount.round(2)
  end

  def add_promotion(promotion)
    promotions << promotion
  end

  def delete_promotions
    promotions.delete_if {|promotion| true }
  end

  private

  def calculate_amount
    self.amount = basket.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f }
    amount
  end

  def apply_price_discounts
    price_promotions.each { |rule| self.amount = rule.apply(amount) }
  end

  def apply_product_discounts
    product_promotions.each { |rule| self.basket = rule.apply(basket) }
  end

  def price_promotions
    promotions.select { |rule| rule.type == :price }
  end

  def product_promotions
    promotions.select { |rule| rule.type == :product }
  end
end
