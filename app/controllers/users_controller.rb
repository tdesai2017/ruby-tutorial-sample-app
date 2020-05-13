class UsersController < ApplicationController
  #Ensures that one must be logged in before using these methods
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  #Ensures that when logged in, only someone who can access this particular page can use these pages
  before_action :correct_user, only: [:edit, :update]
  
  #Enforces that Users cannot use the command line to issue a delete request, and that you must be an admin
  #in order to delete
  before_action :admin_user, only: :destroy
  
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) #Not the final implementation
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcome to the Sample app"
      #handle a successful save
    else
      #Renders the new template now with a @user object that has many errors
      #associated with it
      render 'new'
    end
  end
  
  def edit 
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      #'edit' refers to edit.html.erb view
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
    # Since admin is not included here, someone can't simply send a patch request to this url and update a user
    #to be an admin, which could otherwise be done through the request patch /users/17?admin=1
    def user_params
      return params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
    #confirms admin_user or will redirect them to the root url otherwise
      redirect_to(root_url) unless current_user.admin?
    end
end
  

