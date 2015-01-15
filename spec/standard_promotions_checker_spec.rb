# A sample of a promotion checker, with its rules being tested
describe StandardPromotionsChecker do

  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }
  let(:t_shirt) { double('product', code: '003', name: 'Kids T-shirt', price: '£19.95', class: Product) }

  it 'should be able to check if an amount is over £60' do
    expect(StandardPromotionsChecker.over_60_pounds?(61.00)).to be true
  end

  it 'should know if a basket has more than one lavender heart' do
    basket = [lavender, lavender, cufflinks]
    expect(StandardPromotionsChecker.two_lavender_hearts?(basket)).to be true
  end

  it 'should be able lower the price by 10% if an amount is higher £60' do
    StandardPromotionsChecker.amount = 61.00
    expect(StandardPromotionsChecker.over_60_pounds_price_rule).to eq 54.9
  end

  it 'should be able to lower the price of lavender hearts if there\'s more than 1' do
    basket = [lavender, lavender, cufflinks]
    expect(basket[0]).to receive(:price=).with('£8.50')
    expect(basket[1]).to receive(:price=).with('£8.50')
    expect(basket[2]).not_to receive(:price=)
    StandardPromotionsChecker.two_lavender_hearts_product_rule(basket).each do |product|
      expect(product.class).to eq Product
    end
  end

  it 'should be able to classify it\'s rules as a product or price rule' do
    expect(StandardPromotionsChecker.price_rules).to eq [:over_60_pounds_price_rule]
    expect(StandardPromotionsChecker.product_rules).to eq [:two_lavender_hearts_product_rule]
  end
end
