class Promotion
  class << self
    def over_60_pounds?(amount)
      amount > 60
    end

    def two_lavender_hearts?(products)
      lavender_hearts = products.select { |product| product.name == 'Lavender heart' }
      lavender_hearts.count >= 2
    end
  end
end
