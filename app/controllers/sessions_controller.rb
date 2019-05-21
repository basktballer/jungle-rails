class SessionsController < ApplicationController

  def create
    email = params[:email].strip.downcase
    user = User.find_by_email(email).authenticate_with_credentials(params[:password])
    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
