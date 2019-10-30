class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show, :review]
  
  def index
    @users = User.all.order(:id)
    @categories = Category.all

    @merchant_id = params[:merchantId]
   
    if @merchant_id
      @products  = Product.where(user_id: @merchant_id)
    user_id = params[:query]

    if user_id
      @products  = Product.where(user_id: user_id)
    else
      @products = Product.all
    end

    @category_id = params[:categoryId]
    if @category_id
      @products = Product.joins(:categories).where(:categories => {id: @category_id})
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
    # Assuming this is true:
    #   - We get into this products#rate_product action by submitting a form
    # With questions about:
    #   - What does the form look like? Does it use form_with and a model? Does it use form_with and no model? Does it use a different view helper to create the form?
    # The big question for this action is...
    #   How do we create a Review on product with the right information from the form?
    #      Do we use something like review_params?
    #      What does review_params look like?
    @product = Product.find_by(id: params[:id])
    # @product.reviews << Review.create()

    if session[:user_id] == @product.user_id 
      flash[:message] = "You can't review your own product"
      redirect_to product_path(@product.id)
    else 
      if session[:user_id]
        @product.reviews.create!(review_params.merge({user_id: @login_user.id, product_id: @product.id}))
      else 
        # raise
        @product.reviews.create!(review_params.merge({user_id: nil, product_id: @product.id}))
      end 
      flash[:message] = "Thanks for your review!"
      redirect_to product_path(@product.id)
    end 
  end 

  private
  
  def product_params
    return params.require(:product).permit(:stock, :name, :description, :photo_url, :price, :retired)
  end

  def review_params
    # By virtue of using a form in Rails, we DEF will have a strong_params method like this (aka review_params method)
    # The only reason why this would change is:
    #   1. If review requires different fields
    #   2. If your form view helper is a little different. Aka, it will look like this if you use form_with and a model, it will probably look different if you do something else
    return params.permit(:rating, :user_review)
  end

  def require_login
    if find_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to products_path
    end 
  end 
end
