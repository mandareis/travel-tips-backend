class VotesController < ApplicationController
  before_action :check_auth, only: [:create]
  
  # GET /votes
  def index
    votes = Vote.where(user_id: session[:user_id])

    render json: votes
  end

  # GET /suggestions/:id/vote
  def show
    vote = Vote.find_by(suggestion_id: params[:id], user_id: session[:user_id])
    render json: vote
  end

  # POST /suggestions/:id/vote
  def create
    vote = Vote.find_or_create_by(suggestion_id: params[:id], user_id: session[:user_id]) do |vote|
      vote.direction = params[:direction]
    end

    vote.direction = params[:direction]

    if not vote.valid?
      render json: { :ok => false, :error => vote.errors.full_messages[0] }, status: 400
      return
    end
    if not vote.save
      render json: { :ok => false, :error => "Failed to save vote" }, status: 500
      return
    end
    render json: vote
  end

  # DELETE /suggestions/:id/delete
  def destroy
    vote = Vote.find_by(suggestion_id: params[:id], user_id: session[:user_id])
    vote.destroy
    render json: vote
  end
end
