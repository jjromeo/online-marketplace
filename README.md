Online-marketplace
===========================
[![Code Climate](https://codeclimate.com/github/jjromeo/online-marketplace/badges/gpa.svg)](https://codeclimate.com/github/jjromeo/online-marketplace)


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

Rules can now be added to this class. There are two types of rule, product and price rules. 

####Product rules
Product rules will change attributes of products in basket, and are applied before price rules

To add a product rule, create a method for the rule, and make sure it ends in 'product_rule'. These rules should edit the items in the basket attribute of the checker.

```ruby
class HolidayPromotionsChecker
  extend Promotional
  class << self
    def some_new_product_rule
      if condition
        #code which alters basket items
      end
    end
  end
end
```

####Price rules

Price rules will simply change the total price, they are applied after the product rules. 

To add a price rule, create a method which ends in 'price_rule'. Price rules must change the self.amount property.

```ruby
class HolidayPromotionsChecker
extend Promotional
  class << self
      def some_new_price_rule
          if condition
            #code which returns changes self.amount
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
    
Unless Product::ATTRS array is changed, products must be created like those in checkout.rb in the ITEMS constant eg: 

```ruby    
gloves = Product.new(code: '001', name: 'Wooley gloves', price: '£10.95')
```
Info
==========================
This was a project made to the following specification: 
Our client is an online marketplace, here is a sample of some of the products available on our site:

Product code | Name | Price

001 | Lavender heart | £9.25 |

002 | Personalised cufflinks | £45.00 |

003 | Kids T-shirt | £19.95 |

Our marketing team want to offer promotions as an incentive for our customers to purchase these items.
If you spend over £60, then you get 10% of your purchase
If you buy 2 or more lavender hearts then the price drops to £8.50.
Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.
The interface to our checkout looks like this (shown in Ruby):
co = Checkout.new(promotional_rules) co.scan(item)
co.scan(item)
price = co.total
Implement a checkout system that fulfill’s these requirements.

Test data

Basket: 001,002,003
Total price expected: £66.78
Basket: 001,003,001
Total price expected: £36.95
Basket: 001,002,001,003 Total price expected: £73.76


My approach
-------------
My approach was to make this project using TDD, as this helped me greatly to design how my classes would look. During my tests I made sure to keep the classes completely separate, using doubles to ensure each test only included the class it was testing. This helped me to locate errors more quickly when debugging.

As flexibility to change the promotions was a requirement, I decided to create a module with all of the basic functionality required for a set of promotions, which could be extended into a custom promotions checker class. This had the benefit of keeping new promotional rules separate from the logic required to apply them.

Following on with keeping the promotions flexible, I added some (heavily commented) meta-programming, including a tiny DSL, so that in future, new rules only need to be added in one place in order to be applied to the prices and products.

I also added some perhaps unnecessary flexibility to the Product class, its properties are contained in a Constant at the top of the class. This did however allow me to dry up the code for initializing and validating it.

Given that the checkout would initialize with a single set of rules which it could not make meaningful changes to, I decided to make each rule set a Singleton class. This had the effect of making the code look ever so slightly more complicated and I have since read that Singletons are quite rarely used in ruby and would do some further research before using this again - despite the fact it didn't cause any problems.

In interface.rb I created a small example of how the classes could be used, using the test data. It returns the expected result.

Overall I feel that the project went well as it does all that is asked. If there was one thing that I would have liked to improve it would be too streamline the two types of promotion (price and product) into one type that could all be applied in one go.
