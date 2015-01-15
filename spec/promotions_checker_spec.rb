describe PromotionsChecker do
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  before do
    PromotionsChecker.send(:define_singleton_method, :half_price_rule) do 
      self.amount = amount / 2
    end
    PromotionsChecker.send(:define_singleton_method, :one_free_product_rule) do |product_array|
      product_array.first.price = '£0'
    end
  end

  it 'can give a list of it\'s rules' do
    expect(PromotionsChecker.rules).to eq [:half_price_rule, :one_free_product_rule]
  end

  it 'can give a list of it\'s price rules' do
    expect(PromotionsChecker.price_rules).to eq [:half_price_rule]
  end

  it 'can give a list of it\'s product rules' do
    expect(PromotionsChecker.product_rules).to eq [:one_free_product_rule]
  end

  it 'can apply all of it\'s price rules to an amount' do 
    PromotionsChecker.amount = 50
    PromotionsChecker.apply_price_discounts
    expect(PromotionsChecker.amount).to eq 25
  end

  it 'can apply it\'s product rules to an array' do 
    array = [lavender, cufflinks]
    expect(lavender).to receive(:price=).with('£0')
    PromotionsChecker.apply_product_discounts(array)
  end
end
