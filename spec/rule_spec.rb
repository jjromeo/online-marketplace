require 'spec_helper'
describe Rule do
  it 'has a type' do 
    two_hearts_rule = TwoHeartsRule.new
    expect(two_hearts_rule.type).to eq nil
  end
end
