module TicketsHelper
  include UsersHelper

  def get_refund(ticket)
    days_left = (ticket.event.date.to_date - ticket.updated_at.to_date).to_i

    min = 0.1
    max = 0.6
    max_days = 30
    elapsed_part = (days_left * (max-min) / max_days)
    decrease_ratio = (max - elapsed_part)
    costs = ticket.price * decrease_ratio
    (ticket.price - costs)
  end

  def remaining_count(already_ordered)
    5 - already_ordered
  end

  def invalid_count(rem_count, count)
    rem_count < count || count < -1 || count == 0
  end

  def invalid_age(event, user)
    !event.required_age.blank? && user_age(user) < event.required_age.to_i
  end

  def invalid_free_seat(event, count)
    event.free_seats < count
  end

  def invalid_balance(balance)
    balance < 0
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
