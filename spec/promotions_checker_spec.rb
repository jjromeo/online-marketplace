# Test of a default promotions checker, mixes in promotional but has no other
# methods
describe PromotionsChecker do
  let(:promotions_checker) { PromotionsChecker.new }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  before do
    promotions_checker.class.send(:define_method, :half_price_rule) do 
      self.amount = amount / 2
    end
    promotions_checker.class.send(:define_method, :one_free_product_rule) do 
      self.basket.first.price = '£0'
    end
  end

  it 'can apply all of its price rules to an amount' do 
    promotions_checker.amount = 50
    promotions_checker.send(:apply_price_discounts)
    expect(promotions_checker.amount).to eq 25
  end

  it 'can apply its product rules to an array' do 
    promotions_checker.basket = [lavender, cufflinks]
    expect(lavender).to receive(:price=).with('£0')
    promotions_checker.send(:apply_product_discounts)
  end

end
