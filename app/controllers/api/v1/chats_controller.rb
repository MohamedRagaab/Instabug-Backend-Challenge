module Api
  module V1
    class ChatsController < ApplicationController
      before_action :find_chat_application

      def index
        @chats = @chat_application.chats
        render json: { chats: @chats.as_json(except: :id) }, status: :ok
      end

      def create
        # Enqueue the worker instead of directly creating the chat
        ChatCreationWorker.perform_async(@chat_application.id)

        render json: { message: 'Chat creation job enqueued successfully' }, status: :accepted
      end

      private

      def find_chat_application
        @chat_application = ChatApplication.find_by(token: params[:application_token])

        render json: { errors: 'Chat application not found' }, status: :not_found unless @chat_application
      end
    end
  end
end
