class PlacesController < ApplicationController
  before_action :check_auth
  skip_before_action :check_auth, only: [:countries_list]

  # GET /places
  def index
    @places = Place.all

    render json: @places
  end

  def countries_list
    render json: ISO3166::Country.all.map { |c| { :country => c.name, :code => c.alpha2, :continent => c.region } }
  end

  # GET /places/1
  def show
    render json: @place
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end
end
