class SessionsController < ApplicationController
  def index
    if session[:user_id]
      render json: {
               :ok => true,
               :user_id => session[:user_id],
               :username => session[:username],
               :name => session[:name],
             }
    else
      render json: { :ok => false }
    end
  end

  def create
    user = User.find_by(username: params["username"])
    if not user
      render json: { :ok => false }, status: 401
      return
    end
    if not user.authenticate(params["password"])
      render json: { :ok => false }, status: 401
      return
    end
    session[:user_id] = user.id
    session[:username] = user.username
    session[:name] = user.name
    render json: { :ok => true, :user_id => user.id, :username => user.username, :name => user.name }
  end

  def register
    user = User.create({
      "name" => params[:name],
      "username" => params[:username],
      "email" => params[:email],
      "password" => params[:password],
    })
    if not user
      render json: { :error => user.errors.full_messages[0] }, status: 400
      return
    end
    session[:user_id] = user.id
    session[:username] = user.username
    session[:name] = user.name
    render json: { :ok => true, :user_id => user.id, :username => user.username, :name => user.name }
  end

  def destroy
    reset_session
  end
end
