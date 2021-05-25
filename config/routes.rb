Rails.application.routes.draw do

  root to: "home#index"		# list of all jobs to non-loggedin users
  get "user/jobs", to: "home#user_available_jobs" # list of all jobs to login users
  get "admin/jobs", to: "home#admin_available_jobs" # list of all jobs to login admin
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  post "apply", to: "apply_jobs#create"		# user apply for jobs

  get "admin_login", to: "admins#generate_otp"
  post "admin_login", to: "admins#verify_otp"
  post "admin/jobs/create_job", to: "jobs#create_job"
  patch "admin/jobs/edit_job", to: "jobs#edit_job_status"
  patch "admin/jobs/update_user_status", to: "jobs#update_user_status"
  # get "admin/jobs", to: "jobs#available_job"
  patch "user/password", to: "password#update_password"		# to change user password
  get "profile", to: "profile#get_profile"			# to get user profile
  patch "profile/update", to: "profile#profile_update"
end