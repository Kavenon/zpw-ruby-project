class AuthController < ApplicationController

  layout 'auth'

  def new
  end

  def create
    user = User.find_by(email: params[:auth][:email].downcase)
    if user && user.authenticate(params[:auth][:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] =t('auth.login.incorrect')
      render 'new', layout: 'auth'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
