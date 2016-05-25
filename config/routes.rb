Rails.application.routes.draw do
 

devise_for :views
#devise_for :users
resources :admin_tasks



root to: "home#index"
get "admin" => "admin_tasks#index"


devise_for :users do
  get 'users/sign_out' => 'devise/sessions#destroy'
end

end
