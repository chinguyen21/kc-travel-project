class EventsController < ApplicationController
    before_action :not_logged_in
  def index
    if params[:destination_id]
      if Destination.find_by(id: params[:destination_id]).nil?
        flash[:alert] = ["Destination not found"]
        redirect_to artists_path
      else
        @events = Destination.find(params[:destination_id]).events
      end
    else
      @events = Event.all
    end
  end

  def show
    if params[:destination_id]
      if Event.find_by(id: params[:id], destination_id: params[:destination_id]).nil?
        flash[:alert] = ["Event not found"]
        redirect_to destination_events_path(Destination.find(params[:destination_id]))
      else
        @event = Event.find_by(id: params[:id], destination_id: params[:destination_id])
      end
    else  
      @event = Event.find(params[:id])
    end
  end
end
