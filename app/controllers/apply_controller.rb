class ApplyController < ApplicationController

  before_action :user_login!

  def create
    @job = Job.find_by(id: params[:job_id], status: true)
    if @job.present?
      @uids = Applystatus.where(user_id: Current.user.id)
      if @uids.find_by(job_id: params[:job_id])
        render json: {
            status: 200,
            info: "already applied"
        }
      else
        puts "ELSE"
        @apply = Applystatus.create({
                                        job_id: params[:job_id],
                                        user_id: Current.user.id,
                                        status: false
                                    })
        render json: {
            status: :created
        }
      end
    else
      render json:{
          status: 500,
          info: "Job is inactive."
      }
    end
  end
end