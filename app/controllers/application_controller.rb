class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthHelper
  include EventsHelper

  def check_if_logged
    unless logged_in?
      redirect_to login_url
    end
  end

  def check_if_admin
    unless logged_in?
      redirect_to login_url
    end
  end

end
