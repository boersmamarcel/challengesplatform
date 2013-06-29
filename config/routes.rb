Challengesplatform::Application.routes.draw do
  match '/challenges/page/:page' => "challenges#index"
  match '/challenges/:filter/(page/:page)' => "challenges#index", :constraints => { :filter => /upcoming|running|past|enrolled|supervising/ }

  resources :challenges, :constraints => { :id => /[0-9]+/ } do
    get 'revoke', :on => :member
    get 'enroll', :on => :member
    get 'unenroll', :on => :member
  end

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks", 
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords' 
  }

  resources :users, :except => [:index, :create] do
    get 'profile', :on => :member, :to => "profile#show"
    get 'followers' => 'follow#followers'
    get 'follows' => 'follow#follows'
    resources :follow, :only => [:create, :destroy]
  end

  match "split" => Split::Dashboard, :anchor => false, :constraints => lambda { |request|
    request.env['warden'].authenticated? # are we authenticated?
    request.env['warden'].authenticate! # authenticate if not already
    # or even check any other condition
    request.env['warden'].user.is_admin?
  }
  get "messages/compose", :to => "messages#compose"
  post "messages/deliver", :to => "messages#deliver", :as => :message_deliver
  put "messages/update", :to => "messages#update", :as => :messages_update
  get "messages/autosuggest", :to => "messages#autosuggest"
  get "messages/markasread/:id", :to => "messages#markasread", :as => "markasread"
  
  resources :messages, :only => [:show, :destroy, :index]

  namespace :admin do
    resources :review, :only => [:decline, :approve, :edit, :index, :show, :update] do
      post 'decline', :on => :member
      post 'approve', :on => :member
      get 'edit', :on => :member
      put 'edit', :on => :member
    end

    resources :usermanagement, :only => [:index] do
      get 'index', :on => :member
    end

    resources :users, :only => [:edit, :update, :destroy, :new, :create]
  end

  resources :comment

  namespace :supervisor do
    resources :review 
  end


  get "static/index"
  get "aboutus", :to => "static#aboutus"
  get "team", :to => "static#team"
  get "createchallenge", :to => "static#createchallenge"
  get "challengeguidelines", :to => "static#challengeguidelines"
  get "universities", :to => "static#universities"
  get "companies", :to => "static#companies"
  get "termsofservice", :to => "static#termsofservice"
  get "privacy", :to => "static#privacy"
  get "press", :to => "static#press"

  get "dashboard", :to => "dashboard#index"

  root :to => 'static#index'

end
