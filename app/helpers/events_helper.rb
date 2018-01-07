module EventsHelper

  def get_free_tickets(event)
    10
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
