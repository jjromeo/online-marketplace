# Test of a default promotions checker, mixes in promotional but has no other
# methods
describe PromotionsChecker do
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  before do
    PromotionsChecker.send(:define_singleton_method, :half_price_rule) do 
      self.amount = amount / 2
    end
    PromotionsChecker.send(:define_singleton_method, :one_free_product_rule) do 
      self.basket.first.price = '£0'
    end
  end

  it 'can apply all of its price rules to an amount' do 
    PromotionsChecker.amount = 50
    PromotionsChecker.send(:apply_price_discounts)
    expect(PromotionsChecker.amount).to eq 25
  end

  it 'can apply its product rules to an array' do 
    PromotionsChecker.basket = [lavender, cufflinks]
    expect(lavender).to receive(:price=).with('£0')
    PromotionsChecker.send(:apply_product_discounts)
  end

end
