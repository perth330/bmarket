class UsersController < ApplicationController

  def index
    redirect_to new_user_registration_path
  end

  def show
    @user = User.find(current_user.id)
  end
end
