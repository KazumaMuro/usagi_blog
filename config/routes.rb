Rails.application.routes.draw do
  resources :articles
  root 'articles#index'
  get "pictures" => "articles#pictures"

  get "login" => "articles#login_form"
  post "login" => "articles#login"
  post "logout" => "articles#logout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
