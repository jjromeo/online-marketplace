require_relative 'promotional.rb'

class PromotionsChecker
  include Promotional

  def initialize(*rules)
    rules = rules
  end

end
