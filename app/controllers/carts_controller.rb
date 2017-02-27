class CartsController < ApplicationController
  # include ActionController::MimeResponds

  before_filter :load_user
  before_filter :load_cart, only: [:show, :edit, :update, :destroy]

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

    user_email = params.slice(:users)
    if (!user_email.empty?) 
      user_email = user_email["users"]
      user = User.find_by(email: user_email)
      user.add_cart(@cart._id)      
      @cart.add_user(user_email)

    end

    if @cart.update_attributes(cart_params)
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @cart.admin == @user.email && @cart.destroy
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def load_user
    userId = cart_params.fetch(:userId)
    # @user = User.find(userId)
    @user = User.find_by(email: userId)
  end

  def load_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.slice(:name, :date, :userId)
  end

end
