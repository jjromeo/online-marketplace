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
The Promotion class can be customized to create new rules to be applied to the products.

There are two types of promotion, product and price promotions. 

####Product promotions
Product rules will change attributes of products in basket, and are applied before price rules

To add a product promotion, create a new prmotion class, have it inherit from Promotion, call #set_type_to_product during initialize, and set the #apply method to take in a basket array argument, change it,  and return it(method must return the basket even if it doesn't change it).. These rules should edit the items in the basket array of the checker.

```ruby
class TwoHeartsPromotion < Promotion

  def initialize
    set_type_to_product
  end

  def apply(basket)
    if two_lavender_hearts?(basket)
      return reprice_lavender_hearts(basket)
    end
    basket
  end

  private

  def two_lavender_hearts?(basket)
    lavender_hearts = basket.select { |product| product.name == 'Lavender heart' }
    lavender_hearts.count >= 2
  end

  def reprice_lavender_hearts(basket)
    basket.each { |product| product.price = "£8.50" if product.name == "Lavender heart" }
  end
end

```

####Price promotions

Price rules will simply change the total price, they are applied after the product rules. 

To add a price promotion, create a new promotion class, have it inherit from Promotion, call #set_type_to_price during initialize, and set the #apply method to take in an amount property argument, change it,  and return it(method must return amount even if it doesn't change it).

```ruby
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
```

A discounter can be initialized with as many rules as required, a checkout can be initialized using your discounter, and rules will be automatically applied to the basket when total is called.

```ruby
ten_percent_off = TenPercentOffPromotion.new
two_hearts_discount = TwoHeartsPromotion.new
discounter = Discounter.new(ten_percent_off, two_hearts_discount)
checkout = Checkout.new(discounter)
checkout.scan(gloves)
checkout.scan(wooley_hat)
checkout.scan(scarf)
checkout.total # will return the cost after discounts
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

As flexibility to change the promotions was a requirement, I have made use of the template design pattern, having promotions inherit from the super-class of Promotion, rules can be added and removed as required.

I have removed the meta-programming based approach I originally had to creating rules, in favour of making each rule an object, which better follows the Open-Closed principle, and letting the Discounter simply apply the discounts based on which promotions it has, following the Single Responsibility principle.

In interface.rb I created a small example of how the classes could be used, using the test data. It returns the expected result.

Overall I feel that the project went well as it does all that is asked. If there was one thing that I would have liked to improve it would be too streamline the two types of promotion (price and product) into one type that could all be applied in one go.

