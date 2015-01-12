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
    expect(PromotionChecker.over_60_pounds_rule(61.00)).to eq 54.9
  end

  it 'should be able to lower the price of lavender hearts if there\'s more than 1' do 
  end
end
