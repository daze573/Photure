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
  end

  scope module: :public do
    root 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:index, :create, :destroy]
    end
    resources :tags, only: [:create, :index, :edit, :update, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :users, only: [] do
      resource :information, only: [:show, :edit, :update]
      get 'withdraw' => 'users#withdraw'
      patch 'resign' => 'users#resign'
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :posts, only: [:show] do
      resources :comments, only: [:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
