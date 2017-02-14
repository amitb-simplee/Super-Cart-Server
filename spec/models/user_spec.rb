require 'rails_helper'


describe User do
  before :each do
  	users = FactoryGirl.create_list(:user,3)
  	@user1, @user2, @user3 = users

  	@user2.create_cart("new user's 2 cart")
  	@user3.create_cart("new user's 3 cart")
  end

  it "can create and add a cart to a user" do
  	@user1.create_cart("new user's cart")
  	cart_id = @user1.carts.first
  	cart = Cart.find(cart_id)
  	expect(cart.admin).to eq(@user1._id.to_s)
  	expect(@user1.carts).to include(cart_id)
  end

  it "can add an existing cart to another user"  do
  	origin_cart_id = @user2.carts.first
  	@user1.add_cart(origin_cart_id)
  	cart = Cart.find(@user1.carts.first)

  	expect(cart._id).to eq(origin_cart_id)
  	expect(cart.users).to include(@user1._id)
  end

  it "can destroy a cart (by creater) and delete from all other users list" do
   	# add cart to user 1
   	origin_cart_id = @user2.carts.first
  	@user1.add_cart(origin_cart_id)
  	cart_id = @user1.carts.first
  	expect(cart_id).to eq(origin_cart_id)
  	
  	# delete cart by user 2 - admin
  	@user2.remove_cart(origin_cart_id)
  	@user1.reload
  	expect(@user1.carts).not_to include(origin_cart_id)
  end

  it "can remove a cart (not by creater) and only that user will not be able to see it" do
   	# add cart to user 1
   	origin_cart_id = @user3.carts.first
  	@user1.add_cart(origin_cart_id)
  	cart_id = @user1.carts.first
  	expect(cart_id).to eq(origin_cart_id)

    # delete cart by user 1
  	@user1.remove_cart(origin_cart_id)
  	expect(@user1.carts).not_to include(origin_cart_id)	  
	expect(@user3.carts).to include(origin_cart_id)	 

  end

end

