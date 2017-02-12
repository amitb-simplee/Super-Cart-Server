require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destoy" do
    it "returns http success" do
      get :destoy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show

      expect(response).to have_http_status(:success)
      response_body = JSON.parse(response.body).with_indifferent_access
      expect { response_body }.not_to raise_exception
      expect(response_body).to match({
        _id: 0,
        name: 'test'
      })
    end
  end

end
