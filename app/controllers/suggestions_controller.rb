class SuggestionsController < ApplicationController
  before_action :check_auth
  # GET /suggestions
  def index
    @suggestions = Suggestion.all

    render json: @suggestions
  end

  # GET /suggestions/1
  def show
    render json: @suggestion
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(suggestion_params)

    if @suggestion.save
      render json: @suggestion, status: :created, location: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /suggestions/1
  def update
    suggestion = Suggestion.find(params[:id])
    if @suggestion.update(suggestion_params)
      render json: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /suggestions/1
  def destroy
    @suggestion.destroy
  end
end
