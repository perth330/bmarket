class ProductsController < ApplicationController
  before_action :move_to_root, except: [:index, :show]

  def index
    @categoryProducts = Product.includes(:images).where(status: 0).limit(3).order("id DESC")
    @categoryBrand = Product.includes(:images).where(status: 0).limit(3).order("RAND()")
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    @categories = Category.roots
    @brand = Brand.new
    @product.images.new
  end
  
  def create
    if brand_params{:name} != ""
      @brand = Brand.find_by(name: "#{brand_params}")
      @brand = Brand.create(brand_params) if @brand == nil
    else
      @brand = Brand.find(1)
    end
    @product = Product.new(product_create_params)
    if @product.save
      redirect_to root_path
    else
      @brand = Brand.new
      render "new"
    end
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  private
  def product_create_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price,images_attributes: [:image_url]).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end
  
  def brand_params
    params[:product].require(:brand).permit(:name)
  end

  def move_to_root
    redirect_to new_user_session_path unless user_signed_in?
  end
end