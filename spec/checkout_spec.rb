describe Checkout do
  let(:standard_promotion_checker) { 
    double 'promotion', :rules => [:over_60_pounds_price_rule, :two_lavender_hearts_product_rule],
    product_rules: [:two_lavender_hearts_product_rule], :amount= => nil
  }

  let(:checkout) { Checkout.new(standard_promotion_checker) }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  it 'initializes with a set of promotional rules' do
    expect(checkout.rules).to eq [:over_60_pounds_price_rule, :two_lavender_hearts_product_rule]
  end

  it 'can scan products and store them in a basket' do
    expect(checkout.basket.count).to eq 0
    checkout.scan(lavender)
    expect(checkout.basket.count).to eq 1
  end

  it 'can get the total cost of the products it has' do
    allow(standard_promotion_checker).to receive(:two_lavender_hearts_product_rule).and_return([])
    expect(checkout.sub_total).to eq 0
    checkout.scan(lavender)
    allow(standard_promotion_checker).to receive(:two_lavender_hearts_product_rule).and_return([lavender])
    expect(checkout.sub_total).to eq 9.25
  end

  it 'can apply product discounts when calculating sub_total' do
    some_products = [lavender, lavender, cufflinks]
    some_products.map { |product| checkout.scan(product) }
    expect(standard_promotion_checker).to receive(:two_lavender_hearts_product_rule).with(some_products).and_return(some_products)
    checkout.sub_total
  end

  it 'can apply price discounts when calculating total' do
    some_products = [cufflinks, cufflinks]
    some_products.map { |product| checkout.scan(product) }
    expect(standard_promotion_checker).to receive(:two_lavender_hearts_product_rule).with(some_products).and_return(some_products)
    expect(standard_promotion_checker).to receive(:over_60_pounds_price_rule)
    allow(standard_promotion_checker).to receive(:amount).and_return(90)
    expect(standard_promotion_checker).to receive(:price_rules).and_return [:over_60_pounds_price_rule]
    checkout.total
  end

end
