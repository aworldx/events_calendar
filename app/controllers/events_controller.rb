class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    store_location
  end

  def events_data
    period_from = params[:period_from].to_date
    period_to = params[:period_to].to_date

    events = params[:all_events] ? Event.active : current_user.events.active
    @events = Event.occurrences_between(events, period_from, period_to)
  end

  def show; end

  def new
    @event = current_user.events.build
  end

  def edit; end

  def create
    @event = current_user.events.new(event_params)
    @event.build_shedule_settings

    if @event.save
      flash[:success] = t('messages.event_created')
      render :index
    else
      render :new
    end
  end

  def update
    @event.attributes = event_params
    @event.build_shedule_settings

    if @event.save
      flash[:success] = t('messages.event_updated')
      render :index
    else
      render :edit
    end
  end

  def destroy; end

  private

  def set_event
    @event = Event.find_by(id: params.fetch(:id, nil))
  end

  def event_params
    params.require(:event).permit(:title, :occurance_date, :user_id,
                                  :repeat_interval)
  end

  def correct_user
    redirect_back_or root_url unless current_user?(@event.user)
  end
end
