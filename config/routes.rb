Rails.application.routes.draw do
 

devise_for :views
#Devise routes with custom registrations controller
devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

resources :admin_tasks



get "subscriptions/cancel_subscription" => "subscriptions#cancel_subscription"
get "subscriptions/update_card" => "subscriptions#update_card"
post "subscriptions/update_card_details" => "subscriptions#update_card_details"
resources :subscriptions



root to: "home#index"
get "admin" => "admin_tasks#index"




end
