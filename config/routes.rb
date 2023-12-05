require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root to: "home#index"

  devise_for :users,controllers: {
      registrations: 'users/registrations' ,
      sessions: 'users/otp_sessions'
  }

  devise_scope :user do
    get '/users/otp_email', to: 'users/otp_sessions#new_otp', as: :otp_email
    get '/users/otp_login', to: 'users/otp_sessions#verify_otp_view', as: :otp_login
    post '/users/otp_login', to: 'users/otp_sessions#verify_otp', as: :verify_otp_login
    post '/send_otp', to: 'users/otp_sessions#send_otp', as: :send_otp_user_session
    patch "/resend_otp", to: "users/otp_sessions#resend_otp", as: :resend_otp
  end

  resources :campus_drives do
    resources :application,only: [:new, :create,:index,:update], controller: 'campus_drive_applications' 
    resources :test_attempt, only: [:new, :create, :show, :index] do
      member do
        patch 'submit_paper/:paper_index', to: 'test_attempt#submit_paper', as: :submit_paper
      end
    end 
  end

  resources :job  do
    resources :applications, only: [:new, :create,:index,:update], controller: 'job_applications'
    resources :test_attempt, only: [:new, :create, :show, :index] do
      member do
        patch 'submit_paper/:paper_index', to: 'test_attempt#submit_paper', as: :submit_paper
      end
    end
  end

  resources :users, only: [:index, :show] do
    resources :paper
    resources :test
  end
  get '/success', to: "test_attempt#success"
  resources :question

  match "*unmatched", to: "application#not_found", via: :all
 
end
