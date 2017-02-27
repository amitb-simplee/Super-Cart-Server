class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def edit
  end

  def destoy
  end

  def index
  end

  def show
    @user = {:_id => 0, :name => "test"}
    render json: @user
  end

  def signIn
    begin
       @user = User.find_by(:email => user_params["email"])
    rescue => e
       @user = User.new(user_params)
       @user.save
    end
    if @user
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.slice(:email, :password)
  end

end
