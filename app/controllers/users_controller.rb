class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def index
    redirect_to new_user_registration_path
  end
end
