class ApplicationController < ActionController::API
  before_action :authenticate_request, except: [:login, :register] # Exclude login and register from authentication

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    return if token.blank? || token.nil? || token.empty?
    
    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(decoded_token.first['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end


# class ApplicationController < ActionController::API
#   before_action :authenticate_request, except: [:login, :register]

#   private

#   def authenticate_request
#     header = request.headers['Authorization']
#     token = header.split(' ').last if header
#     begin
#       decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
#       @current_user = User.find(decoded_token.first['user_id'])
#       check_token_expiry(decoded_token.first)
#     rescue JWT::DecodeError
#       render json: { error: 'Invalid token' }, status: :unauthorized
#     rescue JWT::ExpiredSignature
#       render json: { error: 'Token has expired' }, status: :unauthorized
#     rescue ActiveRecord::RecordNotFound
#       render json: { error: 'User not found' }, status: :unauthorized
#     end
#   end

#   def check_token_expiry(decoded_token)
#     exp = decoded_token['exp']
#     raise JWT::ExpiredSignature if Time.at(exp) < Time.now
#   end
# end
