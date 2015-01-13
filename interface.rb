require './lib/product.rb'
require './lib/standard_promotions_checker.rb'
require './lib/checkout.rb'

def get_product_codes(checkout)
  codes = checkout.basket.inject(""){|accu, product| accu + ",#{product.code}" }
  codes[1..-1]
end

lavender = Product.new(code: '001', name: 'Lavender heart', price: '£9.25')
cufflinks = Product.new(code: '002', name: 'Personalised cufflinks', price: '£45.00')
t_shirt = Product.new(code: '003', name: 'Kids T-shirt', price: '£19.95')

co = Checkout.new(StandardPromotionsChecker)
co.scan(lavender)
co.scan(cufflinks)
co.scan(t_shirt)
product_codes = get_product_codes(co)
price = co.total

co2 = Checkout.new(StandardPromotionsChecker)
co2.scan(lavender)
co2.scan(t_shirt)
co2.scan(lavender)
product_codes2 = get_product_codes(co2)

co3 = Checkout.new(StandardPromotionsChecker)
co3.scan(lavender)
co3.scan(cufflinks)
co3.scan(lavender)
co3.scan(t_shirt)
product_codes3 = get_product_codes(co3)

puts 'Test data'
puts '================================'


puts "Basket: #{product_codes}" 
puts "Total price is #{co.total} \n\n"

puts "Basket: #{product_codes2}" 
puts "Total price is #{co2.total} \n\n"

puts "Basket: #{product_codes3}" 
puts "Total price is #{co3.total}"

