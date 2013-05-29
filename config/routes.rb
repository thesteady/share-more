Blogger::Application.routes.draw do
  root :to => "articles#index"

  resource :authors
  resources :articles
  resources :author_sessions

  post 'refresh' => 'authors#refresh',         :as => :refresh
  get 'login'    => 'author_sessions#new',     :as => :login
  get 'logout'   => 'author_sessions#destroy', :as => :logout
  get 'signup'   => 'authors#new',             :as => :signup
end
