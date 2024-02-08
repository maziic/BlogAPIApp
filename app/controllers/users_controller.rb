class UsersController < ApplicationController
  # POST /register
  def create
    user = User.new(user_params)

    if user.save
      render json: { message: 'User created successfully' }
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
end
