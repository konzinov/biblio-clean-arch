Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :catalogue do
    resources :livres do
      collection do
        get 'search'
      end
    end
  end
end
