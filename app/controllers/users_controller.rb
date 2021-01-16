class UsersController < ApplicationController
  def edit
    render json: user, except: [:password_digest]
  end

  # PATCH/PUT /users/1
  def update
    user = User.find(params[:id])

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

  # PATCH/PUT for user's password
  def change_password
    user = User.find(params[:id])
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
    user = User.find(params[:id])
    user.destroy
    render json: user
  end
end
