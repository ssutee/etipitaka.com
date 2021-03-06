Etipitaka::Application.routes.draw do
  resources :posts
  resources :links

  resources :authentications
  resources :bookmarks

  devise_for :users

  match '/search',  :to => 'pages#search'
  match '/read',    :to => 'pages#read'
  match '/compare', :to => 'pages#compare'
  match '/share',   :to => 'bookmarks#share'
  match '/users',   :to => 'users#index'
  match '/users/:id' => 'users#show', :as => :user

  match '/auth/:provider/callback' => 'authentications#create'

  match '/home', :to => 'home_pages#home'
  match '/news', :to => 'home_pages#news'
  match '/news/:id', :to => 'home_pages#recent_news', :as => :new
  match '/background', :to => 'home_pages#background'
  match '/howto/:doc', :to => 'home_pages#howto', :as => :doc
  match '/howto', :to => 'home_pages#howto', :as => :howto
  match '/download', :to => 'home_pages#download'
  

  root :to => "home_pages#home"

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
