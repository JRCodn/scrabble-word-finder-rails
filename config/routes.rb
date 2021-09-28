Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :word, only: [:new, :create, :index, :show]

  get '/search' => 'pages#search', :as => 'search_page'
end
