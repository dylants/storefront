class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @items_for_sale = current_user.items_for_sale
    @items_sold = current_user.items_sold
    @items_purchased = current_user.items_purchased
  end
end