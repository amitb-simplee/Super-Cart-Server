class UserController < ApplicationController
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

  private

  def user_params
    params.slice(:email, :password)
  end

end
