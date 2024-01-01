Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :applications, only: [:create], param: :token do
        resources :chats, only: [:create], param: :number do
          resources :messages, only: [:create] do
            get 'search', on: :collection
          end
        end
      end
    end
  end
end
