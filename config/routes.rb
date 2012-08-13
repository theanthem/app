Anthem::Application.routes.draw do

  devise_for :users, :path => "access", path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { :users => "users" }

  root :to => 'public#home'
  resources :public
  
  scope "/admin" do
    resources :posts, :comments, :categories, :news, :pages, :speakers, :users, :media
    resources :series do
      resources :messages
    end
  end
  
  match 'admin', :to  => 'series#index'
  match 'page/:id', :to => 'public#page'
  match 'archive', :to => 'public#archive'

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
  match ':controller(/:action(/:id))(.:format)'
  
  match ':series_id', :to => 'public#series'
  match ':series_id/:id', :to => 'public#message'
      
  match 'admin/posts/:id/remove_tag/:tag' => 'posts#remove_tag'
  match 'admin/messages/:id/remove_tag/:tag' => 'messages#remove_tag'
  match 'admin/media/:id/remove_tag/:tag' => 'media#remove_tag'
  
end
