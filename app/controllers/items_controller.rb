class ItemsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def edit
    # don't need to load the item, loaded in filter
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

  def update
    # don't need to load the user, since we do it in the filter
    if @item.update_attributes(params[:item])
      flash[:success] = "Item updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  private
    def correct_user
      @item = current_user.items.find(params[:id])
    rescue
      redirect_to root_path
    end

end
