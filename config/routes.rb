Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root 'homes#top'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :tags, only: [:create, :index, :edit, :update, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :users, only: [] do
      resource :information, only: [:show, :edit, :update]
      get 'withdraw' => 'users#withdraw'
      patch 'resign' => 'users#resign'
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :posts, only: [:show] do
      resources :comments, only: [:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
