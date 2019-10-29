class UsersController < ApplicationController
<<<<<<< HEAD
    def index
      @users = User.all
      @categories = Category.all
      @products = Product.all
    end

    def dashboard
      user_id = session[:user_id]
      item = params[:item] || 'products'

      if item == 'products'
        @products = Product.where(user_id: 3) # change to user_id
      else 
        @categories = Category.all
      end
    end
    
    def show
        is_authenticated?
        @user = User.find_by(id: params[:id])
        
        render_404 unless @user
    end
  
    def create
      auth_hash = request.env["omniauth.auth"]
=======

  skip_before_action :require_login, only: [:index, :show, :review], raise: false

  def index
    @users = User.all
    @categories = Category.all
    @products = Product.all
  end
>>>>>>> aa49ccd8cb5eaabe7159f206b3cc6c88cb12a471
  
  def show
      is_authenticated?
      @user = User.find_by(id: params[:id])
      
      render_404 unless @user
  end

  def create
    auth_hash = request.env["omniauth.auth"]

    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      # User was found in the database
      flash[:status] = :success
      flash[:result_text] = "Logged in as returning user #{user.username}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:status] = :success
        flash[:result_text] = "Logged in as new user #{user.username}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:status] = :failure
        flash[:result_text] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end
    
    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    return redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out!"

    redirect_to root_path
  end

  def login
  end

    # still working on it 

      # def signin
      #   user = User.find_by(username: username)
      #   #username = params[:username]
      #   raise

      #   if username and user = User.find_by(username: username)
      #     session[:user_id] = user.id
      #     flash[:status] = :success
      #     flash[:result_text] = "Successfully logged in as existing user #{user.username}"
      #   else
      #     user = User.new(username: username, email: email )
      #     if user.save
      #       session[:user_id] = user.id
      #       flash[:status] = :success
      #       flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
      #     else
      #       flash.now[:status] = :failure
      #       flash.now[:result_text] = "Could not log in"
      #       flash.now[:messages] = user.errors.messages
      #       render "login", status: :bad_request
      #       return
      #     end
      #   end
      #   redirect_to root_path
      # end
      
    private
  
    def is_authenticated?
  
      is_logged_in = session[:user_id]
      if is_logged_in.nil?
        flash[:status] = :failure
        flash[:result_text] = "Can't access"
  
        redirect_to root_path
        return
      end
    end
    
end
