class ProductsController < ApplicationController
  before_action :move_to_root, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :destroy, :update]
  before_action :move_to_root_end_of_products, only: [:show, :update]

  def index
    @categoryProducts = Product.includes(:images).where(status: 0).limit(3).order("id DESC")
    @categoryBrand = Product.includes(:images).where(status: 0).limit(3).order("RAND()")
  end
  
  def new
    @product = Product.new
    @categories = Category.roots
    @brand = Brand.new
    @product.images.new
  end
  
  def create
    brand = Brand.find_by(brand_params)
    if brand == nil
      @brand = Brand.create(brand_params)
    else
      @brand = brand
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
    redirect_to root_path unless move_to_root_end_of_products.nil?
    @productEndes = Purchase.find_by(product_id:@product.id)
    if user_signed_in?
      @addresses = Address.where(user_id:current_user.id)
      @credit = Credit.where(user_id:current_user.id)
    else
    end

  end
  
  def edit
    redirect_to product_path unless user_signed_in? && current_user.id == @product.user_id
    @categories = Category.where(params[:root_id])
    @brand = Brand.find(@product.brand_id)
    @product.images.new
  end

  def update
    if  current_user.id == @product.user_id
      return nil 
    end
    brand = Brand.find_by(brand_params)
    if brand == nil
      @brand = Brand.create(brand_params)
    else
      @brand = brand
    end
    categories = Category.roots
    if @product.update(product_create_params)
      redirect_to root_path
    else
      @brand = Brand.new
      @product.images.new
      render "edit"
    end
  end
  
  def destroy
    if @product.user_id == current_user.id && @product.destroy
      redirect_to root_path, notice:"商品の削除が完了しました。"
    else
      redirect_to root_path, notice:"商品の削除が失敗しました。"
    end
  end

  
  private
  def product_create_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price,images_attributes: [:image_url, :id, :_destroy]).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end

  def brand_params
    params[:product].require(:brand).permit(:name)
  end
  
  def move_to_root
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
  def move_to_root_end_of_products
    @productEndes = Purchase.find_by(product_id:@product.id)
  end
end

