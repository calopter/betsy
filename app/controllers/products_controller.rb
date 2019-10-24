class ProductsController < ApplicationController
  
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

  #a merchange can update THEIR OWN product
  def update
    @product = Work.find_by(id: params[:id])
    
    if @product.nil?
      head :not_found
      return
    elsif @product.update(product_params)
      redirect_to product_path(@product.id)
      return
    else
      head :not_found
    end
  end 

  #a merchant can destroy THEIR OWN product
  def destroy
    selected_prod = Product.find_by(id: params[:id])
    
    if selected_prod.nil?
      head :not_found
      return
    else
      selected_prod.destroy
      redirect_to products_path
    end 
  end 

  #ANY USER can rate a product 
  def rate_product
    @product = Product.find_by(id: params[:id])

    if session[:user_id]
      #not sure if this would grab user_id from session
      @product.reviews.create(review_params)
    else 
      #need to set user_id to nil in params
      @product.reviews.create(review_params)
    end 
    flash[:message] = "Thanks for your review!"
    redirect_to product_path(@product.id)

    #what if there is an error in saving?

  end 

  private
  
  def product_params
    return params.require(:product).permit(:stock, :name, :description, :photo_url, :price, :user_id)
  end

  def review_params
    return params.require(:review).permit(:rating, :review, :product_id, :user_id)
  end

end
