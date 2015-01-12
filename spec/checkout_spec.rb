describe Checkout do
    let(:standard_promotion) { double 'promotion', :rules => [:over_60_pounds, :two_lavender_hearts] }
    let(:checkout) { Checkout.new(standard_promotion) }
    let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }

  it 'initializes with a set of promotional rules' do 
    expect(checkout.rules).to eq [:over_60_pounds, :two_lavender_hearts]
  end

  it 'can scan products and store them in an array' do 
    expect(checkout.products.count).to eq 0
    checkout.scan(lavender)
    expect(checkout.products.count).to eq 1
  end

  it 'can get the total cost of the products it has' do 
    expect(checkout.total).to eq '£0'
    checkout.scan(lavender)
    expect(checkout.total).to eq '£9.25'
  end

end
