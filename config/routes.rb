Shadal::Application.routes.draw do
  devise_for :admins
  ActiveAdmin.routes(self)

  #resources :restaurants
  #resources :menus
  #resources :flyers
  resources :call_logs

  post 'new_call' => 'call_logs#new'
  post 'new_menu' => 'restaurants#new_menu'
  get 'rank'      => 'restaurants#rank'

  # API for sync data on  mobile app
  get 'checkForUpdate' => 'restaurants#checkForUpdate'
  get 'checkForResInCategory' => 'restaurants#checkForResInCategory'
  get 'checkForRestaurants' => 'restaurants#checkForRestaurants'

  get  'allRestaurants' => 'restaurants#allRestaurants'
  get  'allDataGwanak' => 'restaurants#allDataGwanak'

  get 'campuses' => 'campuses#campuses'
  get 'campuses_all' => 'campuses#campuses_all'

  get 'updateDevice' => 'restaurants#updateDevice'

  post 'checkForUpdate' => 'restaurants#checkForUpdate'
  post 'checkForResInCategory' => 'restaurants#checkForResInCategory'
  post 'checkForRestaurants' => 'restaurants#checkForRestaurants'

  get 'update_position'  => 'admin/menus#update_position'

  root :to => 'admin/campuses#index'

# The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
