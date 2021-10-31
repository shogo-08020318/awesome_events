class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show
  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    redirect_to @event, notice: '作成したンゴよ〜' if @event.save
  end

  # def edit
  #   @event = current_user.created_events.find(params[:id])
  # end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_at, :end_at
    )
  end
end
