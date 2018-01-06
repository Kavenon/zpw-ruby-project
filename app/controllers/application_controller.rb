class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthHelper

  def check_if_logged
    unless logged_in?
      redirect_to login_url
    end
  end


end
