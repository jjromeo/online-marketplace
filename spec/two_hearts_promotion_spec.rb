require 'spec_helper'
describe TwoHeartsPromotion do
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  it 'will change the price of lavender hearts if there are two in a basket' do
    basket = [lavender, lavender, cufflinks]
    two_hearts_promotion = TwoHeartsPromotion.new
    expect(lavender).to receive(:price=).with('£8.50').twice
    two_hearts_promotion.apply(basket)
  end
end
