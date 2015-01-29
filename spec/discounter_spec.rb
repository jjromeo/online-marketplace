describe Discounter do
  let(:promotion1) { double('promotion', type: :product) }
  let(:promotion2) { double('promotion', type: :price) }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:basket) { [lavender, cufflinks] }
  let(:amount) { basket.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f } }

  it 'initializes with promotions' do
    discounter = Discounter.new(promotion1, promotion2)
    expect(discounter.promotions).to eq [promotion1, promotion2]
  end
  it 'can get the sum of a basket' do
    discounter = Discounter.new(promotion1, promotion2)
    expect(promotion1).to receive(:apply).and_return(basket)
    expect(promotion2).to receive(:apply).and_return(amount)
    expect(discounter.calculate_total(basket)).to eq 54.25
  end
end
