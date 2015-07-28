Shadal::Application.routes.draw do
  root :to => 'admin/campuses#index'

  devise_for :admins
  ActiveAdmin.routes(self)

  post 'new_call' => 'call_logs#new'
  post 'new_menu' => 'restaurants#new_menu'
  get 'rank'      => 'restaurants#rank'

  # API for sync data on  mobile app
  match 'checkForUpdate' => 'restaurants#checkForUpdate', via: [:get, :post]
  match 'checkForResInCategory' => 'restaurants#checkForResInCategory', via: [:get, :post]
  match 'checkForRestaurants' => 'restaurants#checkForRestaurants', via: [:get, :post]

  get  'allRestaurants' => 'restaurants#allRestaurants'

  # This is for test apk. It includes unconfirmed campus
  get 'campuses_all' => 'campuses#campuses_all'

  # Returns campuses meta data
  get 'campuses' => 'campuses#campuses'

  # Device
  get 'updateDevice' => 'restaurants#updateDevice'

  # Update Position for active admin
  get 'update_position'  => 'admin/menus#update_position'

  # App Minimum Version
  get 'appMinimumVersion' => 'application#minimum_app_version'
end
