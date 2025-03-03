# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    if token
      decoded = JwtService.decode(token)
      if decoded
        @current_user = User.find(decoded[:user_id])
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token required' }, status: :unauthorized
    end
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end