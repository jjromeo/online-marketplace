describe Discounter do
  let(:promotion1) { double(:promotion, type: :product) }
  let(:promotion2) { double(:promotion, type: :price) }
  let(:discounter) { Discounter.new(promotion1, promotion2) }
  let(:lavender) { double(:product, code: '001', name: 'Lavender heart', price: '£9.25') }
  let(:cufflinks) { double(:product, code: '002', name: 'Personalised cufflinks', price: '£45.00') }
  let(:basket) { [lavender, cufflinks] }
  let(:amount) { 54.25 }

  it 'initializes with promotions' do
    expect(discounter.promotions).to eq [promotion1, promotion2]
  end

  it 'allows you to add promotions' do
    promotion3 = double(:promotion, type: :product)
    discounter.add_promotion(promotion3)
    expect(discounter.promotions).to eq [promotion1, promotion2, promotion3]
  end

  it 'allows you to remove all promotions' do
    discounter.delete_promotions
    expect(discounter.promotions).to eq []
  end

  it 'can get the sum of a basket' do
    expect(promotion1).to receive(:apply).and_return(basket)
    expect(promotion2).to receive(:apply).and_return(amount)
    expect(discounter.calculate_total(basket)).to eq 54.25
  end
end
