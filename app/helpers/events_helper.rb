module EventsHelper

  def get_free_tickets(event)
    event.free_seats - event.tickets.count
  end

  def buying_opened(event)
    days_to_event = (event.date.to_date - Date.today).to_i
    days_to_event.to_i <= 30 && days_to_event >= 0
  end

  def has_tickets?(event)
    unless logged_in?
      return false
    end
    event.tickets.where(:user_id => @current_user.id).count > 0
  end

  def is_archived_event?(event)
    event.date < Date.today
  end

  def event_price(event)
    if event.date.today?
      event.price * 1.2
    else
      event.price
    end
  end

end
