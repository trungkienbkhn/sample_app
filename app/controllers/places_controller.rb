class PlacesController < ApplicationController
  before_action :admin_user, except: [:index, :show]
  before_action :find_place, only: %i(show edit update destroy)

  def index
    if params[:status] == "0"
      @places = Place.hotel
      @title = "Hotel"
    else
      @places = Place.restaurant
      @title = "Restaurant"
    end
  end

  def new
    @place = Place.new
  end

  def show; end

  def create
    @place = current_user.places.build (place_params)

    if @place.save
      flash[:success] = "Created new place"
      redirect_to places_path(status: @place.status)
    else
      flash[:warning] = "created fail"
      redirect_to root_path
    end
  end

  def edit; end

  def update
    if @place.update_attributes place_params
      flash[:success] = "place updated"
      redirect_to @place
    else
      render :edit
    end
  end

  def destroy
    if @place.destroy
      flash[:success] = "Deleted place"
      redirect_to places_path(status: @place.status)
    else
      flash[:danger] = "deleted fail"
      redirect_to root_path
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :vote, :cost, :photo, :status)
  end

  def find_place
    @place = current_user.places.find_by id: params[:id]

    return if @place
    flash[:danger] = "not found place"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
