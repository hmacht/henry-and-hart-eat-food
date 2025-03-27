class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :check_admin, only: %i[edit update destroy]

  def index
    @restaurants = Restaurant.order(created_at: :desc)
    @is_admin = is_admin
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurant was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    update_params = restaurant_params

    if params[:restaurant][:photos] == [ "" ]
      update_params = params.require(:restaurant).except(:photos).permit(:name, :address, :review)
    end

    if @restaurant.update(update_params)
      redirect_to @restaurant, notice: "Restaurant was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: "Restaurant was successfully destroyed."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :review, photos: [])
  end
end
