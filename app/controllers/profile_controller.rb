class ProfileController < ApplicationController
  before_action :user_login!

  def get_profile
    @user = User.select("name, email, age, location, phone").find_by(id: Current.user.id)
    render json: {
        profile: @user
    }
  end

  def update_profile
    if Current.user.update(profile_params)
      render json: { status: 200,  profile: @user }
    else
      render json: { status: 500,  info: "Updation failed due to Validations" }
    end
  end
  def update_password
    if Current.user.update(password_params)
      render json: { status: 200,  info: "Password Successfully changed" }
    else
      render json:{
          status: 500,
          info: "Wrong Password"
      }
    end
  end

  private

  def profile_params
    params.permit(:name, :email, :age, :location, :phone)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end

end