Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    # get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :admin do
    # get '/admin/sign_out' => 'devise/sessions#destroy'
  end

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    get 'search' => 'searches#search'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      get "genre_search" => "posts#genre_search"
      get "qrcode" => "posts#qrcode"
    end
    get "search_tag"=>"posts#search_tag"
    resources :tags, only: [:create, :index, :edit, :update, :destroy]
    resources :users, only: [] do
      member do
        get :favorites
      end
      resource :information, only: [:show, :edit, :update]
      get 'withdraw' => 'users#withdraw'
      patch 'resign' => 'users#resign'
    end
  end

  namespace :admin do
    root "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :posts, only: [:show] do
      resources :comments, only: [:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
