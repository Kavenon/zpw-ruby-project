class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_if_logged, only: [:show]

  include ApplicationHelper
  # GET /events
  # GET /events.json
  def index
    @from = Date.today - 30.days
    @to = Date.today + 30.days
    if is_admin?
      @events = Event.all
    else
      @events = Event.all.select{|event| !is_archived_event?(event) || has_tickets?(event)}
    end
  end

  # POST /events
  # POST /events.json
  def filter
    @from = string_to_date(params[:from])
    @to = string_to_date(params[:to])
    @events = Event.where(:date => @from.beginning_of_day..@to.end_of_day)
    render 'index'
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @ticket = Ticket.new

    if is_admin?
      @tickets = Ticket.all
    else
      @tickets = Ticket.where(:user_id => @current_user.id)
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:date, :required_age, :name, :desc, :price, :free_seats, :poster)
    end
end
