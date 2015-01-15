# Must be initialized with a set_of promotions
class Checkout
  attr_reader :basket, :rules_set

  ITEMS = [
    lavender = Product.new(code: '001', name: 'Lavender heart', price: '£9.25'),
    cufflinks = Product.new(code: '002', name: 'Personalised cufflinks', price: '£45.00'),
    t_shirt = Product.new(code: '003', name: 'Kids T-shirt', price: '£19.95')
  ]

  CODES = { '001' => ITEMS[0], '002' => ITEMS[1], '003'=> ITEMS[2] }

  def initialize(promotions_set)
    @basket = []
    @rules_set = promotions_set
  end

  def scan(product)
    basket << product
  end

  def scan_codes(codes)
    codes.each do |code|
      scan(CODES[code])
    end
  end

  def total
    submit_basket
    "#{@rules_set.calculate_total.round(2)}"
  end

  def submit_basket
    @rules_set.basket = basket
  end

end
