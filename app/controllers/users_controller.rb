class UsersController < ApplicationController
  def show
    # @user = User.find(current_user.id)
    @user = User.find(1)
  end
end
