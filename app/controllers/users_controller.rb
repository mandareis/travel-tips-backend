class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  # POST /users
  def create
    user = User.create({
      "name" => params[:name],
      "username" => params[:username],
      "email" => params[:email],
      "password" => params[:password],
      "password_confirmation" => params[:password_confirmation],
    })
    if user.save
      render json: user, except: [:password_digest], status: :created, location: user
    else
      render json: user.errors, except: [:password_digest], status: :unprocessable_entity
    end
  end

  def edit
    render json: user, except: [:password_digest]
  end

  # PATCH/PUT /users/1
  def update
    user = User.where("id = ?", params[:id]).update(get_params)
    render json: user[0], except: [:password_digest]
  end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_user
  #   @user = User.find(params[:id])
  # end

  def get_params
    params.require(:user).permit(:name, :username, :email, :password)
  end
end
