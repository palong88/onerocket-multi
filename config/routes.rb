Rails.application.routes.draw do
 

  resources :admin_tasks



root to: "home#index"
get "admin" => "admin_tasks#index"

end
