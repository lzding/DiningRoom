Rails.application.routes.draw do



  resources :attendance_notes do
    collection do
      get :search
    end
  end

  resources :files do
    collection do
      get :download
    end
  end


  resources :menus do
    collection do
      get :search
      match :import, to: :import, via: [:get, :post]
      get :download
      get :template
    end
  end

  resources :orders do
    collection do
      post :pick
      get :search
      match :import, to: :import, via: [:get, :post]
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


  resources :users do
    collection do
      match :import, to: :import, via: [:get, :post]
      get :template
      get :search
    end
  end



  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  root to: "welcome#index"
end
