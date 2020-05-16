class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to user_path(current_user.id), notice: '登録完了しました。'
    else
      flash.now[:alert] = '未入力項目があります。'
      render :new
    end
  end

  private
  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :zipcode, :prefecture, :city, :town, :town_number, :building, :tel,).merge(user_id: current_user.id)
  end
end
