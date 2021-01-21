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
    user.update({
      "password" => params[:new_password],
    })
    if user
      render json: user, except: [:password_digest]
    end
  end

  # DELETE /users/1
  def destroy
    begin
      user = User.find(session[:user_id])
      suggestion = Suggestion.where("user_id = ?", params[:id]).update_all(user_id: "21")
      vote = Vote.where("user_id = ?", params[:id]).update_all(user_id: "21")
      comment = Comment.where("user_id = ?", params[:id]).update_all(user_id: "21")
      like = Like.where("user_id = ?", params[:id]).update_all(user_id: "21")
    rescue
      render json: { :error => "User Not Found" }, status: 404
    else
      user.destroy
      render json: user
    end
  end
end
