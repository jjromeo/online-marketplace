describe PromotionsChecker do
  before do
    PromotionsChecker.send(:define_singleton_method, :half_price_rule) do
      'a fake rule'
    end
    PromotionsChecker.send(:define_singleton_method, :one_free_product_rule) do
      'another fake rule'
    end
  end

  it 'can give a list of it\'s rules' do
    expect(PromotionsChecker.rules).to eq [:half_price_rule, :one_free_product_rule]
  end

  it 'can give a list of it\'s price rules' do
    expect(PromotionsChecker.price_rules).to eq [:half_price_rule]
  end

  it 'can give a list of it\'s product rules' do
    expect(PromotionsChecker.product_rules).to eq [:one_free_product_rule]
  end
end
