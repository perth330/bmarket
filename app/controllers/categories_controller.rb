class CategoriesController < ApplicationController
  def index
    return nil if params[:keyword] == ""
    @categories = Category.find(params[:keyword]).children
    respond_to do |format|
      format.html
      format.json
    end
  end
end
