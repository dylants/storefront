class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    # use the current_user to populate the dashboard items
  end
end