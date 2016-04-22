require 'spec_helper'
describe MultipleItemPromotion do
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25') }
  let(:lavender2) { double('product', code: '001', name: 'Lavender heart', price: '£9.25') }
  let(:lavender3) { double('product', code: '001', name: 'Lavender heart', price: '£9.25') }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00') }
  let(:two_hearts_promotion) { MultipleItemPromotion.new(product_name: 'Lavender heart', required_quantity: 2, new_price: '£8.50') }

  it 'will not change the price of a product if there is not a sufficient amount' do
    basket = [lavender, cufflinks]
    expect(lavender).not_to receive(:price=)
    two_hearts_promotion.apply(basket)
  end

  it 'will change the price of a product if there is enough in a basket' do
    basket = [lavender, lavender2, cufflinks]
    expect(lavender).to receive(:price=).with('£8.50')
    expect(lavender2).to receive(:price=).with('£8.50')
    expect(cufflinks).not_to receive(:price=)
    two_hearts_promotion.apply(basket)
  end

  it 'will change the price of all relevant items above the threshold ' do
    basket = [lavender, lavender2, lavender3, cufflinks]
    expect(lavender).to receive(:price=).with('£8.50')
    expect(lavender2).to receive(:price=).with('£8.50')
    expect(lavender3).to receive(:price=).with('£8.50')
    expect(cufflinks).not_to receive(:price=)
    two_hearts_promotion.apply(basket)
  end
end
