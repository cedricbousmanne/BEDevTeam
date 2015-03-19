class LocationsController < ApplicationController
  before_filter :set_title, only: :show
  helper_method :coordinates

  def show
    @users = User.near(coordinates)
  end

  private

  def coordinates
    [params[:latitude], params[:longitude]]
  end

  def location
    @location ||= Geocoder.search(coordinates)
  end

  def city_name
    @city_name ||= location.first.address_components.detect{|a| a["types"].include?("locality")}["long_name"]
  end

  def set_title
    @page_title = "Developers near #{city_name}"
  end
end
