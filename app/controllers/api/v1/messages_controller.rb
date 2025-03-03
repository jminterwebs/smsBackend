# app/controllers/api/messages_controller.rb
module Api
  module V1
  class MessagesController < ApplicationController
    # before_action :authenticate_request


    # GET /api/messages
    def index
      @messages = current_user.messages

      render json: @messages.as_json
    end


    # POST /api/messages
    def create
      @twilio_message = Twilio::Send.call(message_params[:messageText])

      if @twilio_message.nil?
        # Log the failure for debugging
        Rails.logger.error "Failed to send Twilio message: #{message_params[:message_text]}"
        # Render an error response
        return render json: {
          errors: ['Failed to send SMS message'],
          message: 'Twilio message sending failed'
        }, status: :unprocessable_entity
      end
      @message = Message.new(message_params.merge(@twilio_message).merge(user: current_user))

      if @message.save
        render json: @message.as_json(except: [:_id], methods: [:id]), status: :created
      else
        render json: { errors: @message.errors.full_messages, message: 'Failed to create message' }, status: :unprocessable_entity
      end
    end

    private

    def set_message
      @message = current_user.messages.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      render json: { message: 'Message not found' }, status: :not_found
    end

    def message_params
      params.require(:message).permit(:numberInput, :messageText)
    end


  end
  end
end

