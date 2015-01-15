require_relative 'promotional.rb'
# is an example of a set of promotions.
class StandardPromotionsChecker
  # Create a rule set by extending Promotional and then adding rules
  # rule set's rules must be singleton methods

  extend Promotional
  class << self
    IS_LAVENDER_HEART = Proc.new { |product| product.name == 'Lavender heart' }

    # product rules will change attributes of basket in basket
    # they are applied before sub_total is calculated
    # to add a product rule create a method which ends in 'product_rule'
    # product rules MUST return the altered array of basket

    def two_lavender_hearts_product_rule
      if two_lavender_hearts?
        reprice_lavender_hearts
      else
        basket
      end
    end

    def two_lavender_hearts?
      lavender_hearts = basket.select(&IS_LAVENDER_HEART)
      lavender_hearts.count >= 2
    end

    # price rules will change the total price
    # they are applied after sub_total and are the last step to calculate total
    # to add a price rule create a method which ends in 'price_rule'
    # price rules must change the self.amount property and return it

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

    def reprice_lavender_hearts
      lavender_hearts = basket.select(&IS_LAVENDER_HEART)
      basket.reject!(&IS_LAVENDER_HEART)
      replace_hearts(lavender_hearts)
    end
    
    def replace_hearts(hearts)
      hearts.each do |heart|
        heart.price = "£8.50"
        basket << heart
      end
    end
  end
end
