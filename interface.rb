require './lib/product.rb'
require './lib/standard_promotions_checker.rb'
require './lib/checkout.rb'

def get_product_codes(basket)
  codes = basket.inject(""){|accu, code| accu + ",#{code}" }
  codes[1..-1]
end

co = Checkout.new(StandardPromotionsChecker)
basket = ['001', '002', '003']
co.scan_codes(basket)
product_codes = get_product_codes(basket)
price = co.total

co2 = Checkout.new(StandardPromotionsChecker)
basket2 = ['001', '003', '001']
co2.scan_codes(basket2)
product_codes2 = get_product_codes(basket2)

co3 = Checkout.new(StandardPromotionsChecker)
basket3 = ['001', '002', '001', '003']
co3.scan_codes(basket3)
product_codes3 = get_product_codes(basket3)

puts 'Test data'
puts '================================'


puts "Basket: #{product_codes}" 
puts "Total price is #{co.total} \n\n"

puts "Basket: #{product_codes2}" 
puts "Total price is #{co2.total} \n\n"

puts "Basket: #{product_codes3}" 
puts "Total price is #{co3.total}"

