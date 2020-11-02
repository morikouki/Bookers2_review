Rails.application.routes.draw do

  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
