require_relative 'promotional.rb'

class PromotionChecker
  extend Promotional
  class << self
    
    def two_lavender_hearts_product_rule(products)
      if two_lavender_hearts?(products)
        reprice_lavender_hearts(products)
      else
        products
      end
    end

    def two_lavender_hearts?(products)
      lavender_hearts = products.select { |product| product.name == 'Lavender heart' }
      lavender_hearts.count >= 2
    end

    def over_60_pounds_price_rule
      if over_60_pounds?(amount)
        self.amount = (amount * 0.9)
      else
        amount
      end
    end

    def over_60_pounds?(amount)
      amount > 60.00
    end

    private

    def reprice_lavender_hearts(products)
      lavender_hearts = products.select { |product| product.name == 'Lavender heart' }
      products.reject! { |product| product.name == 'Lavender heart' }
      lavender_hearts.each do |heart| 
        heart.price = "£8.50" 
        products << heart
      end
      products
    end
  end
end
