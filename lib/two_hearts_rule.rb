class TwoHeartsRule < Rule
  TYPE = :product

  def intialize
    @type = TYPE
  end


  def apply(basket)
    if two_lavender_hearts?
      reprice_lavender_hearts
    end
  end

  private

  def two_lavender_hearts?
    lavender_hearts = basket.select { |product| product.name == 'Lavender heart' }
    lavender_hearts.count >= 2
  end

  def reprice_lavender_hearts(basket)
    basket.each { |product| product.price = "£8.50" if product.name == "Lavender heart" }
  end
end
