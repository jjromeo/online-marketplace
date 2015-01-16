describe Checkout do
  let(:standard_promotion_checker) { 
    double 'promotion', :rules => [:over_60_pounds_price_rule, :two_lavender_hearts_product_rule],
    product_rules: [:two_lavender_hearts_product_rule], :amount= => nil
  }

  let(:checkout) { Checkout.new(standard_promotion_checker) }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  it 'can scan products and store them in a basket' do
    expect(checkout.basket.count).to eq 0
    checkout.scan(lavender)
    expect(checkout.basket.count).to eq 1
  end

  it 'can scan multiple items by their code' do 
    expect(checkout.basket.count).to eq 0 
    checkout.scan_codes(['001', '002', '003'])
    expect(checkout.basket.count).to eq 3
    expect(checkout.basket.all? { |product| product.class == Product }).to eq true
  end

  it 'can send its basket to its promotion checker ' do
    checkout.scan(lavender)
    expect(standard_promotion_checker).to receive(:basket=).with([lavender])
    checkout.submit_basket
  end

  it 'can apply discounts when calculating total' do
    some_products = [cufflinks, cufflinks]
    some_products.each { |product| checkout.scan(product) }
    expect(standard_promotion_checker).to receive(:basket=).with([cufflinks, cufflinks])
    expect(standard_promotion_checker).to receive(:calculate_total)
    checkout.total
  end

end
