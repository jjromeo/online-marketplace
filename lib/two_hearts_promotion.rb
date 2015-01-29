require_relative 'promotion.rb'
#Example product rule
class TwoHeartsPromotion < Promotion

  def initialize
    set_type_to_product
  end

  def apply(basket)
    if two_lavender_hearts?(basket)
      return reprice_lavender_hearts(basket)
    end
    basket
  end

  private

  def two_lavender_hearts?(basket)
    lavender_hearts = basket.select { |product| product.name == 'Lavender heart' }
    lavender_hearts.count >= 2
  end

  def reprice_lavender_hearts(basket)
    basket.each { |product| product.price = "£8.50" if product.name == "Lavender heart" }
  end
end
