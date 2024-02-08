module AuthenticateUser
  def current_user
    @current_user ||= User.find(decoded_token['user_id']) if token_present?
  end

  def token_present?
    request.headers['Authorization'].present?
  end

  def decoded_token
    @decoded_token ||= JWT.decode(token_from_request, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    {}
  end

  def token_from_request
    request.headers['Authorization'].split(' ').last
  end

  def check_token_expiry(decoded_token)
    exp = decoded_token['exp']
    raise JWT::ExpiredSignature if Time.at(exp) < Time.now
  end
end