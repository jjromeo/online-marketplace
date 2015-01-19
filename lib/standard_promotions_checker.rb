require_relative 'promotional.rb'
# is an example of a set of promotions.
class StandardPromotionsChecker
  # Create a rule set by extending Promotional and then adding rules
  # rule set's rules must be singleton methods
  extend Promotional
  class << self
  #disable new as class should only be used as a singleton
  undef_method :new

    # product rules will change attributes of products in the basket
    # they are applied before sub_total is calculated
    # to add a product rule create a method which ends in 'product_rule'
    # product rules must change the attributes of items in the basket

    def two_lavender_hearts_product_rule
      if two_lavender_hearts?
        reprice_lavender_hearts
      end
    end

    # price rules will change the total price
    # they are applied after sub_total and are the last step to calculate total
    # to add a price rule create a method which ends in 'price_rule'
    # price rules must change the self.amount 

    def over_60_pounds_price_rule
      if amount > 60.00
        self.amount = (amount * 0.9)
      end
    end

    private

    def two_lavender_hearts?
      lavender_hearts = basket.select { |product| product.name == 'Lavender heart' }
      lavender_hearts.count >= 2
    end

    def reprice_lavender_hearts
      basket.each { |product| product.price = "£8.50" if product.name == "Lavender heart" }
    end
    
  end
end
