require_relative 'promotion.rb'
# Example price promotion
class TenPercentOffPromotion < Promotion
  def initialize
    set_type_to_price
  end

  def apply(amount)
    amount > 60.00 ? amount * 0.9 : amount
  end
end
