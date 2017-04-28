Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :sites do
    collection do
      post :fetch
      post :update_rank
    end
  end
end
