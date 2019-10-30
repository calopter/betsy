class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show, :review]
  
  def index
    @users = User.all.order(:id)
    @categories = Category.all

    user_id = params[:query]

    if user_id
      @products  = Product.where(user_id: user_id)
    else
      @products = Product.all
    end
  end 

  def show
    product_id = params[:id].to_i
    @product = Product.find_by(id:params[:id])
    if @product.nil?
      head :not_found 
    end
    @order_item = OrderItem.new(order_id: get_cart[:order_id])
  end 

  def new
    @product = Product.new
  end 

  def create
    @product = Product.new(product_params.merge({user_id: @login_user.id}))
    
    if @product.save
      redirect_to product_path(@product.id)
      return
    else
      render new_product_path
    end
  end 

  def edit
    @product = Product.find_by(id: params[:id])
    
    if @product.nil?
      head :not_found
    elsif @product.user_id != @login_user.id
      flash[:message] = "You do not have permission to edit this product."
      redirect_to product_path(@product.id)
    end
  end 

  def update
    @product = Product.find_by(id: params[:id])
    
    if @product.nil?
      head :not_found
      return
    elsif @product.user_id != @login_user.id
      flash[:message] = "You do not have permission to update this product."
      redirect_to product_path(@product.id)
      return 
    else
      @product.update(product_params)
      redirect_to product_path(@product.id)
    end
  end

  def review
    @product = Product.find_by(id: params[:id])

    if session[:user_id] == @product.user_id && session[:user_id] == @login_user.id
      flash[:message] = "You can't review your own product"
      redirect_to product_path(@product.id)
    elsif session[:user_id] != @login_user.id
      @product.reviews.create(review_params.merge({user_id: session[:user_id], product_id: @product.id}))
      flash[:message] = "Thanks for your review!"
      redirect_to product_path(@product.id)
    else 
      @product.reviews.create(review_params.merge({user_id: @login_user.id, product_id: @product.id}))
      flash[:message] = "Thanks for your review!"
      redirect_to product_path(@product.id)
    end 
  end 

  private
  
  def product_params
    return params.require(:product).permit(:stock, :name, :description, :photo_url, :price, :retired)
  end

  def review_params
    return params.permit(:rating, :user_review)
  end

  def require_login
    if find_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to products_path
    end 
  end 
end
