Online-marketplace
===========================


Technologies used
-----------------
- Ruby
- Rspec

How to use
---------------
- Clone repo
- ruby interface.rb to see results

Customizing
------------
The StandardPromotionsChecker contains basic rules for discounts available, however these can be changed or otherwise replaced entirely.

To do this create a class and extend the Promotional module in it:

```ruby
require_relative 'promotional.rb'
class HolidayPromotionsChecker
  extend Promotional
end
```

Rules can now be added to this class, there are two types of rule, product and price rules. 

####Product rules
Product rules will change attributes of products in basket, and are applied before sub_total is calculated.

To add a product rule, create a method for the rule, and make sure it ends in 'product_rule'. It's vital that the method returns an altered version of the array or the array itself.

```ruby
class HolidayPromotionsChecker
  extend Promotional
  class << self
    def some_new_product_rule(array_of_products)
      if condition
      #code which returns altered array of products
      else
          array_of_products
      end
    end
  end
end
```

####Price rules

Price rules will simply change the total price, they are applied to the sub_total and are the last step to calculate the total. 

To add a price rule, create a method which ends in 'price_rule'. Price rules must change the self.amount property, and return it.

```ruby
class HolidayPromotionsChecker
extend Promotional
  class << self
      def some_new_price_rule
          if condition
          #code which returns edits self.amount
          else
              amount #return amount unchanged if not
          end
      end
  end
end
```

Once custom rules are set, a checkout can be initialized using your rule set, and rules will be automatically applied to the basket when total is called.

```ruby
holiday_checkout = Checkout.new(HolidayPromotionsChecker)
holiday_checkout.scan(gloves)
holiday_checkout.scan(wooley_hat)
holiday_checkout.scan(scarf)
holiday_checkout.total # will return the cost after discounts
```
    
Products must be created like those in interface.rb eg: 

```ruby    
gloves = Product.new(code: '001', name: 'Wooley gloves', price: '£10.95')
```
