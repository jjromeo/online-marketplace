describe Checkout do
  let(:discounter) { double 'discounter' }
  let(:checkout) { Checkout.new(discounter) }
  let(:lavender) { double 'product' }

  it 'can scan products and store them in a basket' do
    expect(checkout.basket.count).to eq 0
    checkout.scan(lavender)
    expect(checkout.basket.count).to eq 1
  end

  it 'can use its discounter to calculate total' do
    some_products = [lavender, lavender]
    some_products.each { |product| checkout.scan(product) }
    expect(discounter).to receive(:calculate_total).with(some_products)
    checkout.total
  end

end
