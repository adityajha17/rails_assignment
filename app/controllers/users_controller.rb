class UsersController < ApplicationController
  def sign_up
    if session[:user_id] || session[:phone]
      render json: {
          status: 505,
          errors: "Already logged-in"
      }
    else
      @user = User.new(user_params)

      if @user.save
        session[:user_id] = @user.id
        render json: {
            status: 200,
            info: :created,
            user: @user
        }
      else
        render json: {
            status: 500,
            errors: @user.errors
        }
      end
    end
  end

  def sign_in
    puts  "User_id", session[:user_id], session[:phone]
    if session[:user_id] || session[:phone]
      render json: { status: 500, errors: "Already logged-in" }
    else
      @user = User.find_by(email: params[:email])
      if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        puts "sessionid", session[:user_id]
        render json: {
            status: "Successfully Logged-in",
            user: @user
        }
      else
        render json: {
            status: "Invalid username/password"
        }
      end
    end
  end

  def destroy
    print session[:user_id], "ABC"
    if session[:user_id] || session[:phone]
      reset_session
      render json: {
          status: "Logged-out successfully"
      }
    else
      render json: {
          status: "No user to logout"
      }
    end
  end


  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :location, :age, :phone,)
  end
end
