module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request, only: :login


      def register
        @user = User.new(user_params)

        if @user.save
          token = JwtService.encode(user_id: @user.id.to_s)
          render json: {
            status: { code: 200, message: 'User created successfully' },
            data: {
              user: {
                id: @user.id.to_s,
                name: @user.name,
                email: @user.email
              },
              token: token
            }
          }, status: :created
        else
          render json: {
            status: { code: 422, message: "User couldn't be created. #{@user.errors.full_messages.join(', ')}" }
          }, status: :unprocessable_entity
        end
      end

      def login

        @user = User.find_by(email: permitted_params[:email])

        if @user&.authenticate(permitted_params[:password])
          token = JwtService.encode(user_id: @user.id.to_s)

          puts "------------"
          puts token
          puts "------------"
          render json: { token: token, user: { id: @user.id.to_s, name: @user.name, email: @user.email } }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end


      def logout
        # Since we're using JWT, we don't need to do anything on the server
        # The client will simply delete the token from local storage
        render json: {
          status: { code: 200, message: 'Logged out successfully' }
        }
      end

      def permitted_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end