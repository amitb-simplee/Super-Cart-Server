require 'rails_helper'

RSpec.describe CartController, :type => :controller do

  describe "GET #show" do
    it "shows a cart" do
      cart = Cart.create({:name => "rspec cart show"})
      get :show, id: cart._id
      expect(response).to have_http_status(:success)
      # expect(JSON.parse(response.body)["_id"]).to eq(cart["_id"])
    end
  end

  # describe "GET #index" do
  #   it "returns http success" do
  #     cart = Cart.create({:name => "rspec cart index"})

  #     get :index
  #     byebug
  #     expect(response).to have_http_status(:success)
  #   end
  # end

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
      expect(response).to have_http_status(:success)
      expect(cart["name"]).to eq("rspec cart create")
    end
  end

  describe "GET #update" do
    it "returns http success" do
      #TODO: fix why is it saving the object if seeded?
      cart = Cart.create({:name => "rspec cart show"})
      put :update,  id: cart._id, :name => "rspec cart update"
      expect(JSON.parse(response.body)["name"]).not_to eq(cart["name"])
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "creates and deletes a cart" do
      cart = Cart.create(:name => "destroy test cart")
      delete :destroy, :id => cart._id
      expect { cart.reload }.to raise_error Mongoid::Errors::DocumentNotFound
    end
  end

end
