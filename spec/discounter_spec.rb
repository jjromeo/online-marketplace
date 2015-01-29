# Test of a default promotions checker, mixes in promotional but has no other
# methods
describe Discounter do

  let(:rule1){ double('rule', type: :product) }
  let(:rule2){ double('rule', type: :price) }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:basket) { [lavender, cufflinks] }
  let(:amount) { basket.inject(0) { |accu, product| accu + product.price.slice(1..-1).to_f } }

  it 'initializes with rules' do 
    discounter = Discounter.new(rule1, rule2)
    expect(discounter.rules).to eq [rule1, rule2]
  end
  it 'can get the sum of a basket' do 
    discounter = Discounter.new(rule1, rule2)
    expect(rule1).to receive(:apply).and_return(basket)
    expect(rule2).to receive(:apply).and_return(amount)
    expect(discounter.calculate_total(basket)).to eq 54.25
  end

end
