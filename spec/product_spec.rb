describe Product do
  it 'can be initialized with an attributes hash' do
    product = Product.new(code: '001', name: 'Lavender heart', price: '£9.25')
    expect(product.code).to eq '001'
    expect(product.name).to eq 'Lavender heart'
    expect(product.price).to eq '£9.25'
  end

  it 'will raise an error if it lacks an attribute' do 
    expect{ Product.new(code: '001', name: 'Lavender heart') }.to raise_error 'Error: Missing price attribute'
    expect{ Product.new(name: 'Lavender heart', price: '£9.25') }.to raise_error 'Error: Missing code attribute'
    expect{ Product.new(code: '001', price: '£9.25') }.to raise_error 'Error: Missing name attribute'
  end
end
