class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :destroy]
  before_action :check_if_logged, only: [:create, :destroy]

  include TicketsHelper

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
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

    if rem_count < count || count < -1
      flash[:danger] = t('tickets.new.invalid.count', remaining: rem_count)
    elsif @event.free_seats < count
      flash[:danger] = t('tickets.new.invalid.freeSeats')
    elsif new_balance < 0
      flash[:danger] = t('tickets.new.invalid.balance')
    else

      count.times do |i|
        ticket = @event.tickets.create(:price => event_price(@event), :want_delete => false, :seat => 1)
        @current_user.tickets << ticket
        @current_user.update_attribute("balance", @current_user.balance - event_price(@event))

      end
      flash[:success] = t('tickets.new.success')


    end

    redirect_to event_path(@event)

    # respond_to do |format|
    #   if @ticket.save
    #     format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
    #     format.json { render :show, status: :created, location: @ticket }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @ticket.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
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
