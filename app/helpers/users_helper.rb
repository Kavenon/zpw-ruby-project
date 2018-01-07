module UsersHelper
  require 'date_diff'
  def user_age(user)
    comp = Date.diff(Date.today, @current_user.birthday.to_date)
    comp[:year]
  end
end
