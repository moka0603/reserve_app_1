Rails.application.routes.draw do
  resources :posts
  resources :users
  get "users/:id/show2" => "users#show2"
  patch "users/:id/update2" => "users#update2"
  post "/posts/search" => "posts#search"
  get 'posts/index' => "posts#index"
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "resers" => "resers#index"
  post "resers/new" => "resers#new"
  post "resers/create" => "resers#create"
  get "resers/:id" => "resers#show"
 
  get '/' => "home#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
