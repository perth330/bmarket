class AddressesController < ApplicationController
  def index
    addresses = Address.where(user_id: current_user.id)
    if addresses.blank?
      redirect_to new_address_path
    else
      @addresses = Address.where(user_id: current_user.id)
    end
  end
  
  def new
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: '登録完了しました。'
    else
      flash.now[:alert] = '未入力項目があります。'
      render :new
    end
  end
  
  def destroy 
    address = Address.find_by(id:params[:id])
    if address.present? && address.user_id == current_user.id
      if Purchase.find_by(address_id:address.id) == nil
        address.delete
        redirect_to addresses_path, notice: "削除が完了しました。"
      else
        redirect_to addresses_path, notice: "取引に使われている為、削除できません。"
      end
    else
      redirect_to root_path
    end
  end
  
  private
  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :zipcode, :prefecture, :city, :town, :town_number, :building, :tel,).merge(user_id: current_user.id)
  end
end
