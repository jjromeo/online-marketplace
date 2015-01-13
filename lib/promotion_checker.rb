class PromotionChecker
  class << self

    def rules
      singleton_methods
    end

    def over_60_pounds?(amount)
      amount > 60.00
    end

    def two_lavender_hearts?(products)
      lavender_hearts = products.select { |product| product.name == 'Lavender heart' }
      lavender_hearts.count >= 2
    end

    def over_60_pounds_price_rule(amount)
      if over_60_pounds?(amount)
        amount * 0.9
      else
        amount
      end
    end

    def rules
      singleton_methods.select { |method| method.to_s.split(//).last(4).join == 'rule' }
    end

    def price_rules
      rules.select { |rule| rule.to_s.include?('price') }
    end

    def product_rules
      rules.select { |rule| rule.to_s.include?('product') }
    end

    def two_lavender_hearts_product_rule(products)
      if two_lavender_hearts?(products)
        reprice_lavender_hearts(products)
      else
        products
      end
    end

    private

    def reprice_lavender_hearts(products)
      lavender_hearts = products.select { |product| product.name == 'Lavender heart' }
      discounted_hearts = lavender_hearts.map { |heart| heart.price = "£8.50" }
      products.reject! { |product| product.name == 'Lavender heart' }
      products << discounted_hearts
    end
  end
end
