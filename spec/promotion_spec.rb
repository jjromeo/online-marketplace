describe Promotion do
  it 'has a type' do 
    promotion = Promotion.new
    expect(promotion.type).to eq nil
  end

  it 'will raise an error if applied' do 
    expect {promotion.apply}.to raise_error
  end
end
