describe Promotion do 

  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:t_shirt) { double('product', code: '003', name: 'Kids T-shirt', price: '£19.95', class: Product) }

  it 'should be able to check if an amount is over £60' do 
    expect(Promotion.over_60_pounds?(61)).to be true
  end

  it 'should know if an array has more than one lavender heart' do 
    products = [lavender, lavender, cufflinks]
    expect(Promotion.two_lavender_hearts?(products)).to be true
  end
end
