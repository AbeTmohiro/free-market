Rails.application.routes.draw do
  root to: "items#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks:  "users/omniauth_callbacks"
  }

  devise_scope :user do
    get 'users/select' => 'users/registrations#select'
    get 'users/confirm_phone' => 'users/registrations#confirm_phone'    ## ③電話番号認証画面のアクション
    get 'users/new_address' => 'users/registrations#new_address'        ## ④addressのフォームのアクション
    post 'users/create_address' => 'users/registrations#create_address' ## ⑤addressをsaveするアクション
  end

  resources :users, only: %i(show)

  resources :items, except: %i(destroy) do
    member do
      get "purchase_confirmation"
      post "purchase"
    end
    collection do
      get 'search'
    end
  end
  resources :categories, only: %i(index show)
  resources :cards, only: %i(index new create destroy)

  namespace :api do
    resources :categories, only: %i(index), defaults: { format: 'json' }
  end

end
