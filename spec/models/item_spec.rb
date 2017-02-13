#mongo mongo_super_cart_development

require 'rails_helper'

describe Item do
  before :each do
    @cart = FactoryGirl.build(:cart)
    5.times do
      item = FactoryGirl.build(:item)
      @cart.items << item
    end
  end

  it "should be able to edit an item" do
    item = @cart.items.last
    item.note = "updated item note"

    reloaded_item = @cart.items.last
    expect(reloaded_item).to eq(item)
  end

  it "should be able to check item" do 
    item = @cart.items.last
    item.checked = true

    reloaded_item = @cart.items.last
    expect(reloaded_item.checked).to eq(true)
  end

end