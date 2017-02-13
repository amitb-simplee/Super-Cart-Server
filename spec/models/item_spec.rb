#mongo mongo_super_cart_development

require 'rails_helper'
RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  Mongoid.default_session.collections.select {|c| c.name !~ /system/ }.each(&:drop)

  RSpec.describe Item, :type => :model do
    it { is_expected.to be_embedded_in(:cart).as_inverse_of(:items) }
  end

end

describe Item do
  before :each do
    @item = build(:item)
  end

  it "should be abble to create an item" do
  	expect(@item.name).to eq("item test")
  	expect(@item.quantity).to eq("1")
  	expect(@item.note).to eq("note test")
  end

end