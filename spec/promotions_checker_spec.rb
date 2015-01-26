# Test of a default promotions checker, mixes in promotional but has no other
# methods
describe PromotionsChecker do
  let(:rule1){ double('rule', type: :product) }
  let(:rule2){ double('rule', type: :price) }
  let(:promotions_checker) { PromotionsChecker.new(rule1, rule2) }
  let(:lavender) { double('product', code: '001', name: 'Lavender heart', price: '£9.25', class: Product) }
  let(:cufflinks) { double('product', code: '002', name: 'Personalised cufflinks', price: '£45.00', class: Product) }

  before do
    promotions_checker.class.send(:define_method, :half_price_rule) do 
      self.amount = amount / 2
    end
    promotions_checker.class.send(:define_method, :one_free_product_rule) do 
      self.basket.first.price = '£0'
    end
  end


end
