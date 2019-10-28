class UsersController < ApplicationController
    def index
      @users = User.all
      @categories = Category.all
      @products = Product.all
    end
    
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

    def register

    end

    def signin

    end
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
