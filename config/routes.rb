Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :applications, only: [:create, :show, :update], param: :token do
        resources :chats, only: [:create, :index], param: :number do
          resources :messages, only: [:create, :index, :show, :update] do
            get 'search', on: :collection
          end
        end
      end
    end
  end
end
