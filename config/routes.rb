Rails.application.routes.draw do


<<<<<<< HEAD
  resources :documents
=======
  resources :events
>>>>>>> events-feature
  resources :categories

  post '/attendances/create' => 'attendances#create', :as => :create_attendance
  resources :attendances

  get 'team/scaffold'

  resources :events do
    get :autocomplete_user_name, :on => :collection
  end

  resources :stakeholders

  resources :eadmin_tasks do
<<<<<<< HEAD
		  member do
		    patch :complete
		    patch :not_complete
		    patch :create
        patch :edit
		  end
		end
=======
    member do
      patch :complete
      patch :not_complete
      patch :create
    end
  end
>>>>>>> events-feature

  devise_for :views
  #Devise routes with custom registrations controller
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  resources :admin_tasks
  # get 'admin_tasks/:category' => 'admin_tasks#index'

  resources :users

  get 'users/:id/eadmin_tasks' => 'users#eadmin_tasks', :as => :user_eadmin_tasks
  get 'users/:id/promote_to_admin' => 'users#promote_to_admin', :as => :promote_user_to_admin
  get 'events/:id/attendance' => 'events#attendance', :as => :manage_event_attendance
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

  resources :teams



end
