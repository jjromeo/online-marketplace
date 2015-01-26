class TenPercentOffRule < Rule
  TYPE = :price

  def initialize
    @type = TYPE
  end
  def over_60_pounds_price_rule
    if amount > 60.00
      self.amount = (amount * 0.9)
    end
  end
end
