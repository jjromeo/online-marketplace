require './lib/product.rb'
require './lib/standard_promotions_checker.rb'
require './lib/checkout.rb'

def get_product_codes(basket)
  codes = basket.inject(""){|accu, code| accu + ",#{code}" }
  codes[1..-1]
end

ITEMS = [
  Product.new(code: '001', name: 'Lavender heart', price: '£9.25'),
  Product.new(code: '002', name: 'Personalised cufflinks', price: '£45.00'),
  Product.new(code: '003', name: 'Kids T-shirt', price: '£19.95')
]

#for adding items by code
CODES = { '001' => ITEMS[0], '002' => ITEMS[1], '003'=> ITEMS[2] }

def scan_codes(codes, checkout)
  codes.each do |code|
    checkout.scan(CODES[code])
  end
end

co = Checkout.new(StandardPromotionsChecker.new)
basket = ['001', '002', '003']
scan_codes(basket, co)
product_codes = get_product_codes(basket)
price = co.total

co2 = Checkout.new(StandardPromotionsChecker.new)
basket2 = ['001', '003', '001']
scan_codes(basket2, co2)
product_codes2 = get_product_codes(basket2)

co3 = Checkout.new(StandardPromotionsChecker.new)
basket3 = ['001', '002', '001', '003']
scan_codes(basket3, co3)
product_codes3 = get_product_codes(basket3)

puts 'Test data'
puts '================================'


puts "Basket: #{product_codes}" 
puts "Total price is #{co.total} \n\n"

puts "Basket: #{product_codes2}" 
puts "Total price is #{co2.total} \n\n"

puts "Basket: #{product_codes3}" 
puts "Total price is #{co3.total}"

