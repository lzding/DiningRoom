Rails.application.routes.draw do

  resources :orders do
    collection do
      post :pick
      get :search
      get :import
      get :download
      get :template
    end
  end

  devise_for :users,
             :controllers => {:registrations => "users/registrations"},
             path: "auth",
             path_names: {
                 sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
             }






  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  root to: "welcome#index"
end
