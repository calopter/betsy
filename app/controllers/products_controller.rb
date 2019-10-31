class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show, :review]
  
  #users can browse all products
  def index
    @users = User.all.order(:id)
    @categories = Category.all

    @merchant_id = params[:merchantId]
   
    if @merchant_id
      @products  = Product.where(user_id: @merchant_id)
    #++++++++++++++++++++++++++++++++++++++++++++++
    user_id = params[:query]

    elsif user_id
        @products  = Product.where(user_id: user_id)

    #++++++++++++++++++++++++++++++++++++++++++++++
    else
      @products = Product.all
    end

    @category_id = params[:categoryId]
    if @category_id
      @products = Product.joins(:categories).where(:categories => {id: @category_id})
    end
  end 

  #show each individual product page 
  def show
    product_id = params[:id].to_i
    @product = Product.find_by(id:params[:id])
    if @product.nil?
      head :not_found 
    end
    @order_item = OrderItem.new(order_id: get_cart[:order_id])
  end 

  #bring up new form for merchant to add a product
  def new
    @product = Product.new
    
  end 

  #a merchant can add a new product
  def create
    @product = Product.new(product_params.merge({user_id: @login_user.id}))
    
    if @product.save
      redirect_to dashboard_path(item: 'products')
      return
    else
      render new_product_path
    end
  end 

  #pull up edit form for merchant to edit their product
  def edit
    @product = Product.find_by(id: params[:id])
    @categories = Category.select(:label).map(&:label)

    
    if @product.nil?
      head :not_found
    elsif @product.user_id != @login_user.id
      flash[:message] = "You do not have permission to edit this product."
      redirect_to product_path(@product.id)
    end
  end 

  #a merchant can update their own product
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
      redirect_to dashboard_path(item: 'products')
    end
  end

  # STILL WORKING ON IT - MOMO
  # any user can rate a product 
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

    if session[:user_id] == @product.user_id 
      flash[:message] = "You can't review your own product"
      redirect_to product_path(@product.id)
    else 
      if session[:user_id]
        @product.reviews.create(review_params.merge({user_id: @login_user.id, product_id: @product.id}))
      else 
        @product.reviews.create(review_params.merge({user_id: nil, product_id: @product.id}))
      end 
      flash[:message] = "Thanks for your review!"
      redirect_to product_path(@product.id)
    end 
  end 

  private
  
  def product_params
    return params.require(:product).permit(:stock, :name, :description, :photo_url, :price, :retired, :category_ids => [])
  end

  #STILL WORKING ON THIS -MOMO
  def review_params
    # By virtue of using a form in Rails, we DEF will have a strong_params method like this (aka review_params method)
    # The only reason why this would change is:
    #   1. If review requires different fields
    #   2. If your form view helper is a little different. Aka, it will look like this if you use form_with and a model, it will probably look different if you do something else
    return params.require(:review).permit(:rating, :user_review)
  end

  def require_login
    if find_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to products_path
    end 
  end 
end
