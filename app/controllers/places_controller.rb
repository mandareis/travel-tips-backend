class PlacesController < ApplicationController
  before_action :check_auth
  skip_before_action :check_auth, only: [:countries_list]

  # GET /places
  def index
    places = Place.all

    render json: places
  end
#GET /places/countries-list
  def countries_list
    render json: ISO3166::Country.all.map { |c| { :country => c.name, :code => c.alpha2, :continent => c.region } }
  end

end
