module Promotional

attr_accessor :amount

    def rules
      singleton_methods
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

end
