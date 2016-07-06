Rails.application.routes.draw do


  resources :stakeholders
  resources :eadmin_tasks do
		  member do
		    patch :complete
		    patch :not_complete
		    patch :create
		  end
		end

devise_for :views
#Devise routes with custom registrations controller
devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

resources :admin_tasks
# get 'admin_tasks/:category' => 'admin_tasks#index'

resources :users

get 'users/:id/eadmin_tasks' => 'users#eadmin_tasks', :as => :user_eadmin_tasks
get 'users/:id/promote_to_admin' => 'users#promote_to_admin', :as => :promote_user_to_admin
get "subscriptions/cancel_subscription" => "subscriptions#cancel_subscription"
get "subscriptions/update_card" => "subscriptions#update_card"
post "subscriptions/update_card_details" => "subscriptions#update_card_details"
resources :subscriptions



root to: "home#index"

get "admin" => "admin_tasks#index"
get "employees" => "users#index"
get "new/employee" => "users#new"
get "edit/employee" => "users#edit"



get "etasks" => "eadmin_tasks#index"





end
