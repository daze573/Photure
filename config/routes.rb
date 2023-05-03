Rails.application.routes.draw do
  namespace :admin do
    get 'posts/show'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/withdraw'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'tags/index'
    get 'tags/edit'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
