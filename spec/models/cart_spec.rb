require 'rails_helper'

describe Cart do
  before :each do
    @cart = FactoryGirl.build(:cart)
  end

  it "should be abble to build a cart" do	
  	expect(@cart.name).to eq("factory girl cart")
  end

  it "should be able to add item to cart" do
    item = FactoryGirl.build(:item)
    expect(@cart.items.size).to eq(0)
    @cart.items << item
    expect(@cart.items.size).to eq(1)
  end

  it "should be able to move the item in the cart" do
    moved_item = @cart.items.last
    @cart.move_item(0,@cart.items.size-1)

    expect(@cart.items.first).to eq(moved_item)
  end

  it "should be able to remove items from cart" do
    item = FactoryGirl.build(:item)
    expect(@cart.items.size).to eq(0)
    @cart.items << item
    expect(@cart.items.size).to eq(1)
    @cart.items -= [item]
    expect(@cart.items.size).to eq(0)
  end

end