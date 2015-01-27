require_relative 'promotion.rb'
#Example price rule
class TenPercentOffPromotion < Promotion

  def initialize
    set_type_to_price
  end

  def apply(amount)
    if amount > 60.00
      return amount = (amount * 0.9)
    end
    amount
  end
end
