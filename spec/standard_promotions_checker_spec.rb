# A sample of a promotion checker, with its rules being tested
describe StandardPromotionsChecker do
  let(:promotion_checker) { StandardPromotionsChecker.new }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:t_shirt) { double('product', code: '003', name: 'Kids T-shirt', price: '£19.95', class: Product) }

  it 'should know if a basket has more than one lavender heart' do
    promotion_checker.basket = [lavender, lavender, cufflinks]
    expect(promotion_checker.send(:two_lavender_hearts?)).to be true
  end

  it 'should be able lower the price by 10% if an amount is higher £60' do
    promotion_checker.amount = 61.00
    expect(promotion_checker.over_60_pounds_price_rule).to eq 54.9
  end

  it 'should be able to lower the price of lavender hearts if there\'s more than 1' do
    basket = [lavender, lavender, cufflinks]
    expect(basket[0]).to receive(:price=).with('£8.50')
    expect(basket[1]).to receive(:price=).with('£8.50')
    expect(basket[2]).not_to receive(:price=)
    promotion_checker.calculate_total(basket)
  end

end
