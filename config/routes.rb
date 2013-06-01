Blogger::Application.routes.draw do
  root :to => "articles#index"

  resource :users
  resources :articles

  post 'refresh' => 'users#refresh',  :as => :refresh
  get 'new'      => 'users#new',      :as => :new
  get 'login'    => 'oauths#oauth',   :as => :login
  get 'logout'   => 'oauths#destroy', :as => :logout

  match "oauth/callback" => "oauths#callback", :as => :callback
end
