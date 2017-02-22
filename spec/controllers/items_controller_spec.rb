require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  # describe "GET #show" do
  #   it "shows an item" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #index" do
    it "shows all items of cart" do
      cart = Cart.create({:name => "rspec item index"})   
      get :index, cart_id: cart._id
      expect(response).to have_http_status(:success)

      #expect(JSON.parse(response.body)["_id"]).to eq(cart["_id"])
      
    end
  end

  describe "GET #new" do
    it "creates new item" do
      cart = Cart.create({:name => "rspec item new"})
      item = Item.new({:name => "test item new name", :quantity => "1", :note => "test item new note"})
    
      get :new, :cart_id => cart._id, :name => "test item new name", :quantity => "1", :note => "test item new note"

      # expect(JSON.parse(response.body)["items"].count).to eq(cart["items"].count + 1)
      expect(JSON.parse(response.body)["name"]).to eq(item["name"])
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "creates new item into cart" do
      cart = Cart.create({:name => "rspec item create"})
      item = Item.new({:name => "test item create name", :quantity => "1", :note => "test item create note"})
      post :create, :cart_id => cart._id, :name => "test item create name", :quantity => "1", :note => "test item new note"
      # expect(JSON.parse(response.body)["items"].count).to eq(cart["items"].count + 1)
      expect(JSON.parse(response.body)["name"]).to eq(item["name"])
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET #update" do
    it "updates an item in cart" do
      cart = Cart.create(:name => "update item in cart")
      item = Item.new(:name => "new item in update", :quantity => 1)
      cart.items << item
      put :update, cart_id: cart._id, id: item._id, name: "updated item in cart"
      cart.reload

      expect(cart.items.first["name"]).not_to eq(item["name"])
      expect(cart.items.first["quantity"]).to eq(item["quantity"])
      expect(response).to have_http_status(204)
    end
  end

  describe "GET #destroy" do
    it "destroies an item in a cart" do
      cart = Cart.create(:name => "delete item in cart")
      item = Item.new(:name => "new item to delete")
      post :create, cart_id: cart._id, name: item.name
      cart.reload
      delete :destroy, cart_id: cart._id, id: cart.items.first._id
      cart.reload
      expect(cart.items.count).to eq(0)
      expect(response).to have_http_status(204)
    end
  end

end
