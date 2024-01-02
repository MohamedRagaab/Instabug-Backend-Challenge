module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_chat

      def index
        @messages = @chat.messages
        render json: { messages: @messages.as_json(only: [:number, :body, :created_at, :updated_at]) }, status: :ok
      end

      def show
        @message = @chat.messages.find_by(number: params[:id])

        if @message
          render json: { message: @message.as_json(only: [:number, :body, :created_at, :updated_at]) }, status: :ok
        else
          render json: { errors: 'Message not found' }, status: :not_found
        end
      end

      def update
        @message = @chat.messages.find_by(number: params[:id])

        if @message&.update(message_params)
          render json: { message: 'Message updated successfully', message: @message.as_json(only: [:number, :body, :created_at, :updated_at]) }, status: :ok
        else
          render json: { errors: 'Unable to update message' }, status: :unprocessable_entity
        end
      end

      def create
        # Get the current message number from Redis for the chat
        current_message_number = get_or_set_redis_message_number

        # Enqueue the worker instead of directly creating the message
        MessageCreationWorker.perform_async(@chat.id, message_params[:body])

        render json: { message: 'Message creation job enqueued successfully', message_number: current_message_number }, status: :accepted
      end

      def search
        query = {
          query: {
            bool: {
              filter: [
                { term: { chat_id: @chat.id } },
                { multi_match: { query: params[:q], fields: ['body'] } }
              ]
            }
          }
        }

        @messages = Message.search(query).records

        render json: { messages: @messages.as_json(only: [:number, :body, :created_at, :updated_at]) }, status: :ok
      end

      private

      def find_chat
        @chat = Chat.joins(:chat_application)
                    .find_by(chat_applications: { token: params[:application_token] }, number: params[:chat_number])

        render json: { errors: 'Chat not found' }, status: :not_found unless @chat
      end

      def message_params
        params.require(:message).permit(:body)
      end

      def get_or_set_redis_message_number
        # Redis key format: "app_token:chat_number:message_number"
        key = "#{params[:application_token]}:#{@chat.number}:message_number"
        current_number = redis.get(key).to_i

        redis.incr(key)
        new_number = current_number + 1

        new_number
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end
