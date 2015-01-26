describe Checkout do
  let(:standard_promotion_checker) { double 'promotion' }
  let(:checkout) { Checkout.new(standard_promotion_checker) }
  let(:lavender) { double 'product' }
  let(:cufflinks) { double 'product' }

  it 'can scan products and store them in a basket' do
    expect(checkout.basket.count).to eq 0
    checkout.scan(lavender)
    expect(checkout.basket.count).to eq 1
  end

  it 'can apply discounts when calculating total' do
    some_products = [cufflinks, cufflinks]
    some_products.each { |product| checkout.scan(product) }
    expect(standard_promotion_checker).to receive(:calculate_total)
    checkout.total
  end

end
