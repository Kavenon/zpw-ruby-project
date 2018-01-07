module TicketsHelper
  def remaining_count(already_ordered)
    5 - already_ordered
  end

  def get_free_seat(event)
    taken_seats = event.tickets.collect{|ticket| ticket.seat}
    free_seat = nil
    event.free_seats.times do |i|
      unless taken_seats.include?(i+1)
        free_seat = i + 1
        break
      end
    end
    free_seat
  end
end
