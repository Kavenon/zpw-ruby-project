module EventsHelper

  def get_free_tickets(event)
    event.free_seats - event.tickets.count
  end

  def buying_opened(event)
    (event.date.to_date - Date.today).to_i <= 30
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
