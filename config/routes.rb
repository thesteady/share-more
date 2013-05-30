Blogger::Application.routes.draw do
  root :to => "articles#index"

  resource :authors
  resources :articles
  resources :author_sessions

  post 'refresh' => 'authors#refresh',  :as => :refresh
  get 'login'    => 'oauths#oauth',     :as => :login
  get 'signup'   => 'oauths#oauth',     :as => :signup
  get 'logout'   => 'oauths#destroy',   :as => :logout

  match "oauth/callback" => "oauths#callback", :as => :callback
end
