Challengesplatform::Application.routes.draw do
  match '/challenges/page/:page' => "challenges#index"
  match '/challenges/:filter/(page/:page)' => "challenges#index", :constraints => { :filter => /upcoming|past|mine/ }

  resources :challenges, :constraints => { :id => /[0-9]+/ } do
    get 'revoke', :on => :member
    get 'enroll', :on => :member
    get 'unenroll', :on => :member
  end

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks", 
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  :passwords => 'users/passwords' }

  resources :users do
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
  post "messages/deliver", :to => "messages#deliver"

  resources :messages, :only => [:show, :destroy, :index]

  namespace :admin do
    resources :review do
      post 'comment', :on => :member
      post 'decline', :on => :member
      post 'approve', :on => :member
      get 'edit', :on => :member
      put 'edit', :on => :member
    end

    resources :usermanagement do
      get 'index', :on => :member
    end
  end

  get "static/index"

  get "dashboard", :to => "dashboard#index"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'static#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
