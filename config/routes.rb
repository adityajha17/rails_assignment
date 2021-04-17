Rails.application.routes.draw do

  root to: "home#index"		# Available of all jobs to non-logged users
  post "sign_up", to: "users#sign_up"     # for sign up user
  post "sign_in", to: "users#sign_in"       # for login user
  delete "logout", to: "users#destroy"		# destroy all session( user and admin)
  patch "profile/password", to: "profile#update_password"		# change profile password

  post "apply", to: "apply#create"		# to apply for jobs
  get "generate_otp", to: "admin#generate_otp"	# for admin login and get otp
  post "verify_otp", to: "admin#verify_otp"	# verify otp for admin login
  get "admin/jobs", to: "admin#available_job"	# Available jobs
  post "admin/create_jobs", to: "admin#create_job" # create jobs
  patch "admin/update_jobs", to: "admin#edit_job" #update job status
  patch "admin/update_user", to: "admin#update_user_status"  #admin update user status
  get "profile", to: "profile#get_profile"			# to get candidate profile
  patch "profile/update", to: "profile#update_profile"

end
