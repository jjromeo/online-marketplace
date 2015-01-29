describe Promotion do
  let(:promotion) { Promotion.new }

  it 'has a type attribute' do
    expect(promotion.type).to eq nil
  end

  it 'will raise an error if applied' do
    expect { promotion.apply }.to raise_error RuntimeError
  end

  it 'can set its type to product' do
    promotion.set_type_to_product
    expect(promotion.type).to eq :product
  end

  it 'can set its type to price' do
    promotion.set_type_to_price
    expect(promotion.type).to eq :price
  end
end
