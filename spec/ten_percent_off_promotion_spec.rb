describe TenPercentOffPromotion do
  it 'reduces a value by 10% when applied' do 
    ten_percent_off = TenPercentOffPromotion.new
    expect(ten_percent_off.apply(100)).to eq 90
  end
end
