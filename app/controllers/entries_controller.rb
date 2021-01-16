class EntriesController < ApplicationController
    before_action :not_logged_in
    skip_before_action :verify_authenticity_token
    def new
        @entry = Entry.new
        @itineraries = User.find(session[:id]).itineraries
    end

    def create 
        @entry = Entry.new(entry_params)
        if @entry.save
            redirect_to user_itinerary_path( @entry.itinerary.user, @entry.itinerary)
        else
            flash[:entry_errors] = @entry.errors.full_messages
            redirect_to destination_path(@entry.destination)
        end
    end

    def most_popular_destination
        hash = Hash.new(0)
        Entry.where('visited = true').map {|entry| entry.destination}.each {|d| hash[d]+=1}
        @destinations = hash.sort_by {|h,k| -k}.map {|a| a[0]}
    end


    
    def update 
        # byebug
        @entry = Entry.find(params[:id])
        @entry.update(visited: true)
        redirect_to user_itinerary_path(@entry.itinerary.user, @entry.itinerary)
    end

    private
    def entry_params
        params.require(:entry).permit(:event_id, :date, :itinerary_id, :visited)
    end

    
end

