class ItemController < ApplicationController
  before_filter :load_cart
  before_filter :load_item, only: [:show, :edit, :update, :destroy]
  def show
    @item = load_item
    render json: @items
  end

  def index
    @items = @cart.items
    render json: @items
  end

  def new
    item = Item.new(item_params)
    render json: item
  end

  def create
    # @cart.items << Item.new(item_params)
    item = Item.new(item_params)
    @cart.items << item
    if item.save!
      render json: item
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def edit
    item = Item.new(item_params)
    render json: item
  end

  def update
    if @item.update_attributes!(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      head :no_content
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private

  def load_cart
    @cart = Cart.find(params[:cart_id])
  end

  def load_item
    @item = @cart.items.find(params[:id])
  end

  def item_params
    params.slice(:name, :quantity, :note)
  end
end
