require 'rails_helper'

RSpec.describe UserController, :type => :controller do
  before :each do
    @user_login = FactoryGirl.build(:user)
  end

  it "creates a user in the system" do
  	post :create, :email => @user_login.email, :password => @user_login.password
  	expect(JSON.parse(response.body)["email"]).to eq(@user_login.email)
    expect(response).to have_http_status(:created)
  end

  it "authenticates a user in the system" do
  	post :create, :email => @user_login.email, :password => @user_login.password
  	expect(JSON.parse(response.body)["email"]).to eq(@user_login.email)
    expect(response).to have_http_status(:created)

    #authentication
    expect(User.authenticate(@user_login.email, @user_login.password)).not_to eq(nil)
  end
end