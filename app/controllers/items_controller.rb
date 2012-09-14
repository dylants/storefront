class ItemsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @item = Item.find(params[:id])
  end

  def index
    if params[:query].present?
      # TODO really need to refactor this code
      @tacos = []
      @hot_sauces = []
      @chips = []
      all_items = Item.search(params[:query], load: true)
      all_items.each do |item|
        # for each item, check the type and make sure it's still for sale (no order)
        if (item.item_type == Item.taco) && (item.order.nil?)
          @tacos << item
        end
        if (item.item_type == Item.hot_sauce) && (item.order.nil?)
          @hot_sauces << item
        end
        if (item.item_type == Item.chips) && (item.order.nil?)
          @chips << item
        end
      end
    else
      # gather the item types, and only show the items still for sale
      @tacos = Item.all_for_sale(Item.taco)
      @hot_sauces = Item.all_for_sale(Item.hot_sauce)
      @chips = Item.all_for_sale(Item.chips)
    end
  end

  def new
    @item = Item.new
  end

  def edit
    # don't need to load the item, loaded in filter
  end

  def create
    @item = current_user.items.build(params[:item])
    @item.item_type = Item.derive_item_type_from_content(params[:item][:item_type])
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
