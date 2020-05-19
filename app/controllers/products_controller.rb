class ProductsController < ApplicationController
  before_action :move_to_root, except: [:index, :show]

  def index
    @categoryProducts = Product.includes(:images).limit(3).order("id DESC")
    @categoryBrand = Product.includes(:images).limit(3).order("RAND()")
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
      @product.images.new
      render "new"
    end
  end
  
  def show
    @product = Product.find(params[:id])
    @categories = Category.where(params[:root_id])

  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.where(params[:root_id])
    @brand = Brand.find(@product.brand_id)
    # @image = Image.where(params[:id])

    grandchild_category = @product.category
    child_category = grandchild_category.parent


    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end
  def update
    if brand_params{:name} != ""
      @brand = Brand.find_by(name: "#{brand_params}")
      @brand = Brand.create(brand_params) if @brand == nil
    else
      @brand = Brand.find(1)
    end
    product = Product.find(params[:id])
    categories = Category.roots
    product.update(product_update_params)
    brand = Brand.update(brand_params)
    # product.images.update(image_update_params)
    redirect_to root_path
  end



  private
  def product_create_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price,images_attributes: [:image_url]).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end
  
  def product_update_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price,images_attributes: [:image_url,:_destroy, :id]).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end

  # def image_update_params
  #   params.require(:product).permit(images_attributes: [:image_url,:_destroy,:id],:product_id)
  # endd
    def brand_params
    params[:product].require(:brand).permit(:name)
  end

  def move_to_root
    redirect_to new_user_session_path unless user_signed_in?
  end
  
  


end

