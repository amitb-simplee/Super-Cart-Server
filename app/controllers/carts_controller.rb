class CartsController < ApplicationController
  # include ActionController::MimeResponds

  before_filter :load_user
  before_filter :load_cart, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorization, only: [:edit, :update, :destroy]
  
  def show
    render json: @cart
  end

  def index
    @carts = Cart.any_of({:admin => @user.email},{:users => @user.email})
    render json: @carts
  end

  def new
    @cart = Cart.new(cart_params)
    @cart.admin = cart_params.fetch(:admin, @user.email)
    render json: @cart
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.admin = cart_params.fetch(:admin, @user.email)
    if @cart.save
      render json: @cart, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def edit
    @cart = Cart.new(cart_params)

    render json: @cart
  end

  def update
    #TODO updated_at?
    # unless cart_params.nil?
    #   params[:date] = Time.zone.now
    # end
    user_email = params.slice(:addUser)
    add_user(user_email["addUser"]) unless (user_email.empty?) 

    remove_user_email = params.slice(:removeUser)
    remove_user(remove_user_email["removeUser"]) unless (remove_user_email.empty?) 

    if @cart.update_attributes(cart_params)
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.delete_cart(@cart) 
    if @cart.destroy
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def add_user(user_email)
      if @cart.admin == @user.email
        user = User.find_by(email: user_email)
        user.add_cart(@cart)
        @cart.add_user(user)
        head :no_content
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
      
  end

  def remove_user(remove_user)
    if @cart.admin == @user.email
      user = User.find_by(email: remove_user)
      user.remove_cart(@cart)      
      @cart.remove_user(user)
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def admin_authorization
    if @cart.admin != @user.email
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def load_user
    userId = cart_params.fetch(:userId)
    # @user = User.find(userId)
    @user = User.find_by(email: userId)
  end

  def load_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.slice(:name, :date, :userId, :addUser, :removeUser)
  end

end
