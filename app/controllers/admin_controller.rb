class AdminController < ApplicationController
  def generate_otp
    if session[:user_id]
      render json: { status: :failed, errors: "user is already logged-in" }
    else
      if session[:phone]
        render json: { status: "already logged-in as Admin" }
      else
        if params[:phone].to_i > 7000000000 && params[:phone].to_i < 9999999999
          session[:otp] = rand(111111..999999)
          puts "OTP is:", session[:otp]
          session[:number] = params[:phone]
          puts "Phone no is:",params[:phone]
          render json: { status: :"Checked otp" }
        else
          render json: { status: 500, info: "Enter correct number" }
        end
      end
    end
  end


  def verify_otp
    if session[:user_id]
      render json: { status: :failed, errors: "user is already logged-in" }
    elsif session[:phone]
      render json: { status: "already logged-in as Admin" }
    elsif session[:number] == params[:phone]
      session_otp = session[:otp]
      params_otp = params[:otp].to_s
      if session_otp == params[:otp].to_i
        session[:phone] = session[:number]
        session[:number] = nil
        @admin = Admin.new(admin_params)
        @admin.save
        puts "ADMIN", @admin.errors
        render json: { status: "Admin logged-in", phone: params[:phone] }
      else
        render json: { status: "OTP doesn't match" }
      end
    else
      render json: { status: "Enter correct phone number" }
    end
  end

  def available_job
    if session[:phone]
      @jobs = Job.all
      @users = User.all
      @all_applied_jobs = Applystatus.select("user_id, job_id, status")
      render json: {
          jobs: @jobs,
          user: @users,
          all_applied_jobs: @all_applied_jobs
      }
    else
      render json: { status: 500, info: "need an Admin Login" }
    end
  end

  def create_job
    if session[:phone]
      @job = Job.new(job_params)
      if @job.save
        render json: { status: 200, info: "Job created" }
      else
        render json: { status: 500, errors: @job.errors }
      end
    else
      render json: { status: 500, info: "Admin should login" }
    end
  end

  def edit_job
    if session[:phone]
      @job = Job.find_by(id: params[:id])
      if @job.present?
        if @job.update(edit_job_status)
          render json: { status: 200, info: :status_changed, job: @job }
        else
          render json: { status: 500, info: "Validation errors" }
        end
      else
        render json: { status: 500, info: "Job does not exist" }
      end
    else
      render json: { status: 500, info: "Need Admin Login"}
    end
  end

  def update_user_status
    if session[:phone]
      @usr = Applystatus.find_by(jid: params[:job_id], uid: params[:user_id])
      puts "errors", @usr
      if @usr.present?
        if @usr.update(user_job_status)
          @status = Applystatus.find_by(job_id: params[:job_id], user_id: params[:user_id])
          if @status.status == true
            render json: { status: 200,  info: "User Selected, Email sent." }
          else
            render json: { status: 200,  info: :status_changed }
          end
        else
          render json: { status: 500 }
        end
      else
        render json: { status: 500,  info: "No available job(s) for this User" }
      end
    else
      render json: { status: 500,  info: "Need Admin Login" }
    end
  end

  private

  def admin_params
    params.permit(:phone, :otp)
  end
  def job_params
    params.permit(:title, :description, :category, :exp, :status)
  end

  def edit_job_status
    params.permit(:status)
  end

  def user_job_status
    params.permit(:status)
  end
end
