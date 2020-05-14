class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    Address.create(address_params)
    redirect_to root_path
  end

  private
  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :zipcode, :prefecture, :city, :town, :town_number, :building, :tel,).merge(user_id: current_user.id)
  end
end
