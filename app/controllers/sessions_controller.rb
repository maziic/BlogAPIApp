class SessionsController < ApplicationController
  # POST /login
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end
end
