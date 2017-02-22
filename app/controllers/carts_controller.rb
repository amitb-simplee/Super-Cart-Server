class CartsController < ApplicationController
  # include ActionController::MimeResponds
  # user authentication
  # ApiV1 Convtroller
  before_filter :load_cart, only: [:show, :edit, :update, :destroy]

  def show
    render json: @cart
  end

  def index
    @carts = Cart.find_by(user: params[:userId])
    #TODO: to be implmeneted when user is created
    render json: @cart
  end

  def new
    @cart = Cart.new(cart_params)
    render json: @cart
  end

  def create
    @cart = Cart.new(cart_params)
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
    unless cart_params.nil?
      params[:date] = Time.zone.now
    end

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
    params.slice(:name, :date)
  end

end
