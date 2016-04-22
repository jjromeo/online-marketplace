describe 'Market place' do

  context 'When given the sample inputs' do

    let(:lavender_heart) { Product.new(code: '001', name: 'Lavender heart', price: '£9.25') }
    let(:cufflinks) { Product.new(code: '002', name: 'Personalised cufflinks', price: '£45.00') }
    let(:tshirt) {Product.new(code: '003', name: 'Kids T-shirt', price: '£19.95') }

    context 'will come out with the expected results' do
      let(:two_hearts_discount) { MultipleItemPromotion.new(product_name: 'Lavender heart', required_quantity: 2, new_price: '£8.50') }
      let(:ten_percent_off) { PercentageOffPromotion.new(percentage: 10, required_amount: 60) }
      let(:discounter) { Discounter.new(ten_percent_off, two_hearts_discount) }

      it 'first basket returns £66.78' do
        co = Checkout.new(discounter)
        co.scan(lavender_heart)
        co.scan(cufflinks)
        co.scan(tshirt)
        expect(co.total).to eq '£66.78'
      end

      it 'second basket returns £36.95' do
        co = Checkout.new(discounter)
        co.scan(lavender_heart)
        co.scan(tshirt)
        co.scan(lavender_heart)
        expect(co.total).to eq '£36.95'
      end

      it 'third basket returns £73.76' do
        co = Checkout.new(discounter)
        co.scan(lavender_heart)
        co.scan(cufflinks)
        co.scan(lavender_heart)
        co.scan(tshirt)
        expect(co.total).to eq '£73.76'
      end
    end
  end
end
