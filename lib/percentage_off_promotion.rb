require_relative 'promotion.rb'
# Example price promotion
class PercentageOffPromotion < Promotion
  attr_reader :percentage, :required_amount
  def initialize(options = {})
    set_type_to_price
    @percentage = options[:percentage]
    @required_amount = options[:required_amount]
  end

  def apply(amount)
    amount >= required_amount ? reduced_amount(amount) : amount
  end

  private

  def reduced_amount(amount)
    amount * (1 - (percentage * 0.01))
  end
end
