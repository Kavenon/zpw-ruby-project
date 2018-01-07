module TicketsHelper
  def remaining_count(already_ordered)
    5 - already_ordered
  end
end
