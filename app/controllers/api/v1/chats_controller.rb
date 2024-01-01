module Api
  module V1
    class ChatsController < ApplicationController
      before_action :find_chat_application

      def index
        @chats = @chat_application.chats
        render json: { chats: @chats.as_json(except: :id) }, status: :ok
      end

      def create
        @chat = @chat_application.chats.new

        if @chat.save
          render json: { message: 'Chat created successfully', chat: { number: @chat.number } }, status: :created
        else
          render json: { errors: @chat.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_chat_application
        @chat_application = ChatApplication.find_by(token: params[:application_token])

        render json: { errors: 'Chat application not found' }, status: :not_found unless @chat_application
      end
    end
  end
end
