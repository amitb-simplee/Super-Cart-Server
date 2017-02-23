require 'rails_helper'

RSpec.describe CartsController, :type => :controller do

  describe "GET #show" do
    it "shows a cart" do
      cart = Cart.create({:name => "rspec cart show"})
      get :show, id: cart._id
      expect(response).to have_http_status(:success)
      # expect(JSON.parse(response.body)["_id"]).to eq(cart["_id"])
    end
  end

  describe "GET #index" do
    it "returns http success" do
      cart = Cart.create({:name => "rspec cart index", :admin => "user1"})
      cart1 = Cart.create({:name => "rspec cart index 2", :admin => "user2"})
      cart2 = Cart.create({:name => "rspec cart index 3", :admin => "user1"})
      get :index, userId: cart.admin
      
      carts = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(carts[0]["name"]).to eq("rspec cart index")
      expect(carts[1]["name"]).not_to eq("rspec cart index 2")
      expect(carts[1]["admin"]).to eq(cart.admin)
    end
  end

  describe "GET #new" do
    it "can create a new cart" do
      cart = Cart.new({:name => "rspec cart show"})
      get :new, :name => "rspec cart show"
      expect(response).to have_http_status(:success)
      # expect(JSON.parse(response.body)["name"]).to eq(cart["name"])
    end
  end

  describe "GET #create" do
    it "creates and saves a cart" do
      post :create, :name => "rspec cart create"
      cart = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(cart["name"]).to eq("rspec cart create")
    end
  end

  describe "GET #update" do
    it "returns http success" do
      #TODO: fix why is it saving the object if seeded?
      cart = Cart.create({:name => "rspec cart show"})
      cart_name = cart.name
      put :update,  id: cart._id, :name => "rspec cart update"
      cart.reload
      expect(cart["name"]).not_to eq(cart_name)
      expect(response).to have_http_status(204)
    end
  end

  describe "GET #destroy" do
    it "creates and deletes a cart" do
      cart = Cart.create(:name => "destroy test cart")
      delete :destroy, :id => cart._id
      expect { cart.reload }.to raise_error Mongoid::Errors::DocumentNotFound
      expect(response).to have_http_status(204)
    end
  end

end
