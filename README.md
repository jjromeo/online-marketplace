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

The MultipleItemPromotion can cater for discounts based on purchasing
a certain amount of products, but fully customized product promotions can be added.

To add a product promotion, create a new promotion class, have it inherit from Promotion, call #set_type_to_product during initialize, and set the #apply method to take in a basket array argument, change it,  and return it(method must return the basket even if it doesn't change it).. These rules should edit the items in the basket array of the checker.


```ruby

class MultipleItemPromotion < Promotion
  attr_reader :product_name, :required_quantity, :new_price
  def initialize(options = {})
    set_type_to_product
    @product_name = options[:product_name]
    @required_quantity = options[:required_quantity]
    @new_price = options[:new_price]
  end

  def apply(basket)
    sufficient_quantity?(basket) ? reprice_products(basket) : basket
  end

  private

  def sufficient_quantity?(basket)
    relevant_products = basket.select { |product| relevant_product?(product) }
    relevant_products.count >= required_quantity
  end

  def relevant_product?(product)
    product.name == product_name
  end

  def reprice_products(basket)
    basket.each { |product| product.price = '£8.50' if relevant_product?(product)}
  end

```

####Price promotions

Price rules will simply change the total price, they are applied after the product rules. 

The PercentageOffPromotion can cover basic needs when a discount based on the total amount in a customers basket is needed, but fully customized percentages can also be added.

To add a price promotion, create a new promotion class, have it inherit from Promotion, call #set_type_to_price during initialize, and set the #apply method to take in an amount property argument, change it,  and return it(method must return amount even if it doesn't change it).

```ruby
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
```

A discounter can be initialized with as many rules as required, a checkout can be initialized using your discounter, and rules will be automatically applied to the basket when total is called.

```ruby
two_hearts_discount = MultipleItemPromotion.new(product_name: 'Lavender heart', required_quantity: 2, new_price: '£8.50')
ten_percent_off = PercentageOffPromotion.new(percentage: 10, required_amount: 60) 
discounter = Discounter.new(ten_percent_off, two_hearts_discount)
checkout = Checkout.new(discounter)
checkout.scan(lavender_heart)
checkout.scan(cufflinks)
checkout.scan(tshirt)
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

This TDD and OOP approach which I used a year ago helped me greatly in refactoring and improving the project, as due to the tests and classes being self-contaned and not having too many dependencies, I was able to edit the bits I wanted to without breaking it as I went along.

As flexibility to change the promotions was a requirement, I have made use of the template design pattern, having promotions inherit from the super-class of Promotion, rules can be added and removed as required.

Overall I feel that the project went well as it does all that is asked. 

Coming back to the project after over a year, I have improved the specs, made the default discounts easier to change, and added an acceptance test to test the whole procedure.

