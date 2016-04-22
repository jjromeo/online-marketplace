describe PercentageOffPromotion do
  let(:ten_percent_off) { PercentageOffPromotion.new(percentage: 10, required_amount: 60 ) }

  it 'will take in the percemtage you will reduce, and the required amount to allow the discount' do
    expect(ten_percent_off.percentage).to eq 10
    expect(ten_percent_off.required_amount).to eq 60
  end
  it 'will not reduce a value which is lower than the threshold' do
    expect(ten_percent_off.apply(20)).to eq 20
  end

  it 'reduces a value which is higher than the threshold' do
    expect(ten_percent_off.apply(100)).to eq 90
  end
end
