class BrandsController < ApplicationController
  def index
    return nil if params[:keyword] == ""
    @brands = Brand.where(['name LIKE ?', "%#{params[:keyword]}%"] ).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end
  def new
    return nil if params[:keyword] == ""
    @brand = Brand.where(['name LIKE ?', "%#{params[:keyword]}%"] ).limit(1)
    respond_to do |format|
      format.html
      format.json
    end
  end

end
