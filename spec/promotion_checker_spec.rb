describe PromotionChecker do 

  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:t_shirt) { double('product', code: '003', name: 'Kids T-shirt', price: '£19.95', class: Product) }

  it 'should be able to check if an amount is over £60' do 
    expect(PromotionChecker.over_60_pounds?(61.00)).to be true
  end

  it 'should know if an array has more than one lavender heart' do 
    products = [lavender, lavender, cufflinks]
    expect(PromotionChecker.two_lavender_hearts?(products)).to be true
  end
  
  it 'should be able lower the price by 10% if an amount is higher £60' do 
    expect(PromotionChecker.over_60_pounds_price_rule(61.00)).to eq 54.9
  end

  it 'should be able to lower the price of lavender hearts if there\'s more than 1' do 
    products = [lavender, lavender, cufflinks]
    expect(products[0]).to receive(:price=).with('£8.50')
    expect(products[1]).to receive(:price=).with('£8.50')
    PromotionChecker.two_lavender_hearts_product_rule(products)
  end

  it 'should be able to classify it\'s rules as a product or price rule' do 
    expect(PromotionChecker.price_rules).to eq [:over_60_pounds_price_rule]
    expect(PromotionChecker.product_rules).to eq [:two_lavender_hearts_product_rule]
  end
end
