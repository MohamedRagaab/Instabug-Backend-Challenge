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
        # Enqueue the worker instead of directly creating the message
        MessageCreationWorker.perform_async(@chat.id, message_params[:body])

        render json: { message: 'Message creation job enqueued successfully' }, status: :accepted
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

        render json: { errors: 'Message not found' }, status: :not_found unless @chat
      end

      def message_params
        params.require(:message).permit(:body)
      end
    end
  end
end
