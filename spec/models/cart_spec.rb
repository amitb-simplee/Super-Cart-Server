require 'rails_helper'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
    # Clean/Reset Mongoid DB prior to running the tests


  RSpec.describe Cart, :type => :model do
    it { is_expected.to embed_many(:items) }
  end
  
end

describe Cart do
  before :each do
    @cart = build(:cart)
  end

  it "should be abble to create a cart" do	
  	expect(@cart.name).to eq("cart test")
  end

  it "should be abble to create a cart on the db" do
  	params = {:name => "test create cart"}
    cart = Cart.new(params)
  	cart.save!
  	expect(Cart.find_by(:_id => cart._id).name).to eq("test create cart")
  end

end