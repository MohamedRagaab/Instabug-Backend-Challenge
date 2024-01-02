module Api
  module V1
    class ChatsController < ApplicationController
      before_action :find_chat_application

      def index
        @chats = @chat_application.chats
        render json: { chats: @chats.as_json(except: :id) }, status: :ok
      end

      def create
        # Get the current chat number from Redis
        current_chat_number = get_current_chat_number(@chat_application.token)

        # Increment the chat number in Redis
        increment_current_chat_number(@chat_application.token)

        # Enqueue the worker instead of directly creating the chat
        ChatCreationWorker.perform_async(@chat_application.id)

        render json: { message: 'Chat creation job enqueued successfully', chat_number: current_chat_number + 1 }, status: :accepted
      end

      private

      def find_chat_application
        @chat_application = ChatApplication.find_by(token: params[:application_token])

        render json: { errors: 'Chat application not found' }, status: :not_found unless @chat_application
      end

      def get_current_chat_number(application_token)
        redis_key = "current_chat_number:#{application_token}"
        redis.get(redis_key).to_i
      end

      def increment_current_chat_number(application_token)
        redis_key = "current_chat_number:#{application_token}"
        redis.incr(redis_key)
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end
