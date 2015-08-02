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

  # New Campuses Reservation
  post 'campus/reservation' => 'campus_reservations#create'
  #
  ##### Campuses Controller #####


  ##### Restaurants Controller #####
  #
  # Returns restaurant
  get 'restaurant/:restaurant_id' => 'restaurants#show'
  # Good
  get 'restaurant/:restaurant_id/is_good/:uuid' => 'restaurants#is_good'
  # Bad
  get 'restaurant/:restaurant_id/is_bad/:uuid' => 'restaurants#is_bad'
  # New Restaurant Correction
  post 'restaurant/:restaurant_id/restaurant_corrections' => 'restaurant_corrections#create'
  # New Restaurant Suggestion
  post 'restaurant_suggestion' => 'restaurant_suggestions#create'
  #
  ##### Restaurants Controller #####
  
  ##### CallLogs Controller #####
  #
  # New CallLog
  # 
  post 'call_logs' => 'call_logs#create'
  #
  ##### CallLogs Controller #####
  
  ##### Users Controller #####
  #
  # New User Request
  # 
  post 'user/:user_id/request' => 'user_requests#create'
  #
  ##### Users Controller #####

  ##### Devices Controller #####
  #
  # Device
  post 'update_device' => 'devices#update_device'
  #
  ##### Devices Controller #####

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
