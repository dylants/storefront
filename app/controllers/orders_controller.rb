class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def create
    item = Item.find(params[:order][:item_id])
    item.buy_item!(current_user)
    respond_to do |format|
      format.html do
        flash[:success] = "You have successfully purchased the #{item.name}!"
        redirect_to "/dashboard"
      end
      format.js
    end
  end
end