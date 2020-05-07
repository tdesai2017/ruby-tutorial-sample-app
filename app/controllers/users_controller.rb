class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) #Not the final implementation
    #U
    if @user.save
      redirect_to @user
      flash[:success] = "Welcome to the Sample app"
      #handle a successful save
    else
      #Renders the new template now with a @user object that has many errors
      #associated with it
      render 'new'
    end
  end
  
  private

    def user_params
      return params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
  

