class HomeController < ApplicationController
  def index
    if session[:phone]		# for Admins
      @jobs = Job.all
      @users = User.all
      @all_applied_jobs = ApplyStatus.select("job_id, user_id, status")
      render json: {
          jobs: @jobs,
          user: @users,
          all_applied_jobs: @all_applied_jobs
      }
      #for logged user
    elsif Current.user
      @jobs = Job.where(status: true)
      @applied_jobs = ApplyStatus.select("status").where(job_id: @jobs, user_id: Current.user.id)
      render json: {
          jobs: @jobs,
          applied_jobs: @applied_jobs
      }
      # for non-logged-in users
    else
      @jobs = Job.where(status: true)
      render json: {
          jobs: @jobs
      }
    end
  end
end
