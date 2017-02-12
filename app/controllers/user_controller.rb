class UserController < ApplicationController
  def new
  end

  def create
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
end
