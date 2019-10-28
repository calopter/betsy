class ProductsController < ApplicationController
  # require login for all the actions except the following...
  # skip_before_action :require_login, only[:index, :show, :review]
  
  #show all the products available for sale to ALL users
  def index
    @products = Product.all
  end 

  #show each individual product page 
  def show
    product_id = params[:id].to_i
    @product = Product.find_by(id:params[:id])
    if @product.nil?
      head :not_found 
    end
  end 

  #bring up new form for merchant to add a product
  def new
    @product = Product.new
  end 

  #a merchant can add a new product
  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to product_path(@product.id)
      return
    else
      render new_product_path
    end
  end 

  #pull up edit form for merchant to edit THEIR OWN product
  def edit
    @product = Product.find_by(id: params[:id])
    
    if @product.nil?
      head :not_found
    end
  end 

  #a merchant can update THEIR OWN product
  def update
    @product = Product.find_by(id: params[:id])
    
    if @product.nil?
      head :not_found
      return
    else
      @product.update(product_params)
      redirect_to product_path(@product.id)
    end
  end 

  #a merchant can destroy THEIR OWN product
  def destroy
    if session[:user_id]
      selected_prod = Product.find_by(id: params[:id])
      
      if selected_prod.nil?
        head :not_found
        return
      elsif 
        selected_prod.user_id != session[:user_id]
        flash[:message] = "You do not have permission to delete this product."
        redirect_to product_path(selected_prod.id)
        return 
      else
        selected_prod.destroy
        redirect_to products_path
        return
      end 
    else 
      flash[:message] = "You must be a merchant to do this"
      redirect_to product_path(selected_prod.id)
    end 
  end 

  #ANY USER can rate a product 
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
        #not sure if this would grab user_id from session
        @product.reviews.create(review_params)
      else 
        #need to set user_id to nil in params
        @product.reviews.create(review_params)
      end 
      flash[:message] = "Thanks for your review!"
      redirect_to product_path(@product.id)
    end 
  end 

  private
  
  def product_params
    return params.require(:product).permit(:stock, :name, :description, :photo_url, :price, :user_id, :retired)
  end

  def review_params
    # By virtue of using a form in Rails, we DEF will have a strong_params method like this (aka review_params method)
    # The only reason why this would change is:
    #   1. If review requires different fields
    #   2. If your form view helper is a little different. Aka, it will look like this if you use form_with and a model, it will probably look different if you do something else
    return params.require(:review).permit(:rating, :user_review, :product_id, :user_id)
  end

end
