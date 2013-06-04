Blogger::Application.routes.draw do
  resource :users
  resources :articles

  namespace :api do
    namespace :v1 do 
      resources :articles
    end
  end

  post 'refresh' => 'users#refresh',  :as => :refresh
  get 'new'      => 'users#new',      :as => :new
  get 'login'    => 'oauths#oauth',   :as => :login
  get 'logout'   => 'oauths#destroy', :as => :logout

  match "oauth/callback" => "oauths#callback", :as => :callback

  root :to => "articles#index"
end
