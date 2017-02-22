class CartsController < ApplicationController
  # include ActionController::MimeResponds
  # user authentication
  # ApiV1 Convtroller
  before_filter :load_cart, only: [:show, :edit, :update, :destroy]

  def show
    render json: @cart
  end

  def index
    userId = cart_params.fetch(:userId)
    @carts = Cart.where(admin: userId)
    #TODO: to be implmeneted when user is created
    render json: @carts
  end

  def new
    @cart = Cart.new(cart_params)
    @cart.admin = cart_params.fetch(:admin, "amit")
    render json: @cart
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.admin = cart_params.fetch(:admin, "amit")
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
    
    if @cart.update_attributes(cart_params)
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @cart.destroy
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def load_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.slice(:name, :date, :userId)
  end

end
