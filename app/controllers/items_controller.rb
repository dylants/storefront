class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item Created!"
      redirect_to @item
    else
      render 'new'
    end
  end
end
