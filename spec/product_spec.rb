require 'spec_helper'
describe Product do 
  it 'can be initialized with an attributes hash' do 
    product = Product.new(code: '001', name: 'Lavender heart', price: '£9.25')
    expect(product.code).to eq '001'
    expect(product.name).to eq 'Lavender heart'
    expect(product.price).to eq '£9.25'
  end

end
