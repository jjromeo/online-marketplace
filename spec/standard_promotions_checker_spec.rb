# A sample of a promotion checker, with its rules being tested
describe StandardPromotionsChecker do

  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:t_shirt) { double('product', code: '003', name: 'Kids T-shirt', price: '£19.95', class: Product) }

  it 'should know if a basket has more than one lavender heart' do
    StandardPromotionsChecker.basket = [lavender, lavender, cufflinks]
    expect(StandardPromotionsChecker.send(:two_lavender_hearts?)).to be true
  end

  it 'should be able lower the price by 10% if an amount is higher £60' do
    StandardPromotionsChecker.amount = 61.00
    expect(StandardPromotionsChecker.over_60_pounds_price_rule).to eq 54.9
  end

  it 'should be able to lower the price of lavender hearts if there\'s more than 1' do
    StandardPromotionsChecker.basket = [lavender, lavender, cufflinks]
    expect(StandardPromotionsChecker.basket[0]).to receive(:price=).with('£8.50')
    expect(StandardPromotionsChecker.basket[1]).to receive(:price=).with('£8.50')
    expect(StandardPromotionsChecker.basket[2]).not_to receive(:price=)
    StandardPromotionsChecker.apply_discounts
  end

end
