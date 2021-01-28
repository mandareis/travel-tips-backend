class SuggestionsController < ApplicationController
  before_action :check_auth, only: [:create]
  # GET /suggestions
  def index
    if not params[:city]
      render json: { :ok => false, :error => "'city' param MUST be specified" }, status: 400
      return
    end
    suggestions = Suggestion.paginate(page: params[:page], per_page: 5).includes(:place).joins(:place).where("lower(places.city) = ?", params[:city].downcase)
 
  # # get all suggestions
  #   total = Suggestion.joins(:place).where("lower(places.city) = ?", params[:city].downcase).count

    if not suggestions
      render json: { :ok => false, :error => "Failed to find place." }, status: 400
      return
    end
    render json: {
      next_page: suggestions.next_page != nil,
      data: suggestions
    }, :include => [:place]
  end
 
# GET /suggestions/upvoted (all suggestions voted up by specific user)
  def upvoted
    suggestions = Suggestion.includes(:place).joins(:votes).where("votes.direction = 1 AND votes.user_id = ?", session[:user_id])
    render json: suggestions.to_json(:include => [:place])
  end

  # GET /suggestions/1
  def show
    suggestion = Suggestion.includes(:place).find(params[:id])
    render json: suggestion.to_json(:include => [:place])
  end

  #get_votes
  def get_votes
    vote = Vote.where(suggestion_id: params[:id]).sum(:direction)

    render json: vote
  end

  # POST /suggestions
  def create
    if params[:description].length > 1_500
      render json: { :ok => false, :error => "Exceed character limit of description" }, status: 400
      return
    end
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
end
