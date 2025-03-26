class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @restaurants = Restaurant.all
  end
end
