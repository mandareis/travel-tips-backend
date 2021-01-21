class SuggestionsController < ApplicationController
  before_action :check_auth, only: [:create]
  # GET /suggestions
  def index
    # suggestions = Suggestion.all
    suggestions = Suggestion.includes(:place).joins(:place).where(places: { city: params[:city] })
    if not suggestions
      render json: { :ok => false, :error => "Failed to find place." }, status: 400
    end
    render json: suggestions.to_json(:include => [:place])
  end

  # GET /suggestions/1
  def show
    suggestion = Suggestion.includes(:place).find(params[:id])
    render json: suggestion.to_json(:include => [:place])
  end

  # POST /suggestions
  def create
    place = Place.new do |p|
      p.continent = params[:place][:continent]
      p.country = params[:place][:country]
      p.name = params[:place][:name]
      p.city = params[:place][:city]
    end

    if not place.valid?
      render json: { :ok => false, :error => place.errors.full_messages.join("; ") }, status: 400
      return
    end
    if not place.save
      render json: { :ok => false, :error => "Failed to save place" }, status: 500
      return
    end

    suggestion = Suggestion.new do |s|
      s.title = params[:title]
      s.description = params[:description]
      s.labels = params[:labels]
      s.user_id = session[:user_id]
      s.place = place
    end

    if not suggestion.valid?
      render json: { :ok => false, :error => suggestion.errors.full_messages.join("; ") }, status: 400
      return
    end
    if not suggestion.save
      render json: { :ok => false, :error => "Failed to save suggestion" }, status: 500
      return
    end
    render json: suggestion
  end

  # PATCH/PUT /suggestions/1
  # def update
  #   suggestion = Suggestion.find(params[:id])
  #   if @suggestion.update(suggestion_params)
  #     render json: @suggestion
  #   else
  #     render json: @suggestion.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /suggestions/1
  # def destroy
  #   @suggestion.destroy
  # end
end
