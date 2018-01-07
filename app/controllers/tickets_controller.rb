class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :destroy]
  before_action :check_if_logged, only: [:create, :destroy]
  before_action :check_if_admin, only: [:index, :show, :redir]

  include EventsHelper
  include TicketsHelper
  include UsersHelper

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  def redir
    @ticket = Ticket.find(params[:ticket_id])
    redirect_to ticket_path(@ticket)
  end
  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @event = Event.find(params[:event_id])

    count = params[:ticket][:count].to_i

    already_ordered_by_user = Ticket.where(:user_id => @current_user.id, :event_id => @event.id).count
    rem_count = remaining_count(already_ordered_by_user)
    total_price = count * event_price(@event)
    new_balance = @current_user.balance - total_price

    if buying_opened(@event)
      flash[:danger] = t('tickets.new.invalid.toEarly')
    elsif rem_count < count || count < -1 || count == 0
      flash[:danger] = t('tickets.new.invalid.count', remaining: rem_count)
    elsif !@event.required_age.blank? && user_age(@current_user) < @event.required_age.to_i
      flash[:danger] = t('tickets.new.invalid.requiredAge')
    elsif @event.free_seats < count
      flash[:danger] = t('tickets.new.invalid.freeSeats')
    elsif new_balance < 0
      flash[:danger] = t('tickets.new.invalid.balance')

    else

      # count.times do |i|
      #   ticket = @event.tickets.create(:price => event_price(@event), :want_delete => false, :seat => get_free_seat(@event))
      #   @current_user.tickets << ticket
      #   @current_user.update_attribute("balance", @current_user.balance - event_price(@event))
      # end
      flash[:success] = t('tickets.new.success')

    end

    redirect_to event_path(@event)

  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy

    if is_admin? && @ticket.want_delete
      days_left = (@ticket.event.date.to_date - @ticket.updated_at.to_date).to_i
      refund = get_refund(days_left, @ticket.price)
      @ticket.user.update_attribute("balance", @ticket.user.balance + refund)
      @ticket.destroy
    elsif is_admin? || @ticket.user_id == @current_user.id
      @ticket.update_attribute("want_delete", true)
    end

    redirect_to event_path(@ticket.event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.permit(:count)
    end
end
