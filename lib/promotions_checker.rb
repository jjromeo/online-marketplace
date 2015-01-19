require_relative 'promotional.rb'

class PromotionsChecker
  extend Promotional
  class << self 
  #disable new as class should only be used as a singleton
  undef_method :new
  end
end
