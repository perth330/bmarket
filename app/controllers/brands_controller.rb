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
    @brand = Brand.find_by(name: "#{params[:keyword]}")
    if @brand == nil
      @brand = Brand.new
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

end
