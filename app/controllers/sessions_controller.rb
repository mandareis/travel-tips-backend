class SessionsController < ApplicationController
  def index
    if session[:user_id]
      user = User.find(session[:user_id])

      render json: {
               :ok => true,
               :user_id => session[:user_id],
               :username => user.username,
               :name => user.name,
               :email => user.email,
             }
    else
      render json: { :ok => false }
    end
  end

  # create user's session
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
    render json: { :ok => true, :user_id => user.id, :username => user.username, :name => user.name, :email => user.email }
  end

  # create user
  def register
    user = User.create({
      "name" => params[:name],
      "username" => params[:username],
      "email" => params[:email],
      "password" => params[:password],
    })
    ok = user.save
    if not ok
      render json: { :ok => false, :error => user.errors.full_messages[0] }, status: 400
      return
    end
    session[:user_id] = user.id
    render json: { :ok => true, :user_id => user.id, :username => user.username, :name => user.name, :email => user.email }
  end

  def dump_session
    render json: session
  end

  # loads user
  def bootstrap_js_data
    data = nil
    if session[:user_id]
      user = User.find(session[:user_id])
      data = {
        :user_id => session[:user_id],
        :username => user.username,
        :name => user.name,
        :email => user.email,
      }
    end
    render :js => "window._bootstrap_data = JSON.parse('#{data.to_json}');"
  end

  #logs out user
  def destroy
    reset_session
    render json: {
             status: 200,
           }
  end
end
