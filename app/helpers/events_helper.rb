module EventsHelper

  def get_free_tickets(event)
    10
  end

  def is_archived_event?(event)
    event.date < Date.today
  end

end
