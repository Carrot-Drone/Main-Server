Shadal::Application.routes.draw do
  root :to => 'admin/campuses#index'

  devise_for :admins
  ActiveAdmin.routes(self)

  ##### Campus Controller #####
  #
  # Returns campuses meta data
  get 'campuses' => 'campuses#campuses'

  # This is for test apk. It includes unconfirmed campus
  get 'campuses_all' => 'campuses#campuses_all'

  # Return restaurants in campus
  get 'campus/:campus_id/restaurants' => 'campuses#restaurants'

  # Returns restaurants' meta data in campus
  get 'campus/:campus_id/category/:category_id/restaurants' => 'campuses#restaurants_in_category'
  #
  ##### Campus Controller #####


  ##### Restaurant Controller #####
  #
  # Returns restaurant
  get 'restaurant/:restaurant_id' => 'restaurants#show'
  #
  ##### Restaurant Controller #####
  
  ##### CallLog Controller #####
  #
  # New CallLog
  # 
  match 'call_logs' => 'call_logs#create', via: [:get, :post]
  #
  ##### CallLog Controller #####

  ##### Device Controller #####
  #
  # Device
  match 'update_device' => 'devices#update_device', via: [:get, :post]
  #
  ##### Device Controller #####

  ##### Application Controller #####
  #
  # App Minimum Version
  get 'minimum_app_version' => 'application#minimum_app_version'
  #
  ##### Application Controller #####

  ##### Active admin #####
  #
  # Update Position for active admin
  get 'update_position'  => 'admin/menus#update_position'
  #
  ##### Active admin #####

  # DEPRECATED 'API for sync data on mobile app'
  match 'checkForUpdate' => 'restaurants#checkForUpdate', via: [:get, :post]
  match 'checkForResInCategory' => 'restaurants#checkForResInCategory', via: [:get, :post]
  match  'allRestaurants' => 'restaurants#allRestaurants', via: [:get, :post]
  post 'new_call' => 'call_logs#create_new'
  get 'updateDevice' => 'devices#update_device_deprecated'
  get 'appMinimumVersion' => 'application#minimum_app_version'
end
