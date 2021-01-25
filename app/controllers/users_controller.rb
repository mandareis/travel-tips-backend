class UsersController < ApplicationController
  before_action :check_auth, only: [:update, :change_password, :destroy]

  # PATCH/PUT /users/1
  def update
    user = User.find(session[:user_id])
    user.update({
      "name" => params[:name],
      "username" => params[:username],
      "email" => params[:email],
    })
    ok = user.save
    if not ok
      render json: { :error => user.errors.full_messages[0] }, status: 400
      return
    end
    render json: user, except: [:password_digest]
  end

  # PATCH/PUT /user/change_password for user's password
  def change_password
    user = User.find(session[:user_id])
    if not user.authenticate(params[:old_password])
      render json: { :error => "Password incorrect" }, status: 401
      return
    end
    result = user.change_password(params[:new_password])
    if not result 
      render json: {:error => user.errors.full_messages[1] }, status: 400
      return
    end
    render json: user, except: [:password_digest]
  end

  # DELETE /users/1
  def destroy
    begin
      ghost = User.find_by(username: "ghost")
      user = User.find(session[:user_id])
      suggestion = Suggestion.where("user_id = ?", params[:id]).update_all(user_id: ghost.id)
      vote = Vote.where("user_id = ?", params[:id]).update_all(user_id: ghost.id)
      comment = Comment.where("user_id = ?", params[:id]).update_all(user_id: ghost.id)
      like = Like.where("user_id = ?", params[:id]).update_all(user_id: ghost.id)
    rescue
      render json: { :error => "User Not Found" }, status: 404
    else
      user.destroy
      render json: user
    end
  end
end
