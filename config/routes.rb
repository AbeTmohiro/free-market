Rails.application.routes.draw do
  root to: "items#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get 'users/select' => 'users/registrations#select'
    get 'users/confirm_phone' => 'users/registrations#confirm_phone'
    get 'users/new_address' => 'users/registrations#new_address'
    get 'users/completed' => 'users/registrations#completed'
  end

  resources :users, only: %i(show)

  resources :items, except: %i(destroy) do
    member do
      get "purchase_confirmation"
    end
    collection do
      get 'search'
    end
  end
  resources :categories, only: %i(index show)
  resources :cards, only: %i(index new)

end
