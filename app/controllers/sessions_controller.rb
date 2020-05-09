class SessionsController < ApplicationController
  def new
    # @user = User.new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      #Same as user_url(user) --> redirects to correct user "show" page
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destory
    log_out
    redirect_to root_url
  end
end
