class DestinationsController < ApplicationController
    before_action :not_logged_in
    layout "destination_nav_page"
    def index
        @user = User.find(session[:id])
        @countries = Destination.all.map {|d| d.country}.uniq
        @states = Destination.all.map {|d| d.state}.uniq
        if !params[:state].blank? && !params[:city].blank?
            flash[:alert] = "Choose 1 category to filter at a time"
            @destinations = []
            redirect_to destinations_path
            
        elsif !params[:state].blank?
            @destinations = Destination.find_by_state(params[:state])
        elsif !params[:city].blank?
            @destinations = Destination.find_by_city(params[:city])
        elsif params[:category] == "Popularity"
            @destinations = Destination.most_popular_destinations
        elsif params[:category] == "Rating high to low" && !params[:limit].blank?
            @a_destinations = Destination.highest_to_lowest_rating_destinations.first(params[:limit].to_i)
        elsif params[:category] == "Rating high to low"
            @a_destinations = Destination.highest_to_lowest_rating_destinations
        elsif params[:category] == "Rating low to high" && !params[:limit].blank?
            @a_destinations = Destination.lowest_to_highest_rating_destinations.first(params[:limit].to_i)
        elsif params[:category] == "Rating low to high"
            @a_destinations = Destination.lowest_to_highest_rating_destinations
        elsif params[:limit]
            @destinations = Destination.all.first(params[:limit].to_i)
        else
            @destinations = []
        end
    end


    def new 
        @destination = Destination.new
        @destination.events.build
    end

    def create
         @destination = Destination.new(destination_params)
        if @destination.save
            redirect_to @destination 
        else
            flash[:errors] = @destination.errors.full_messages
            redirect_to new_destination_path
        end
    end
    
    def show
        @destination = Destination.find(params[:id])
        @itineraries = User.find(session[:id]).itineraries.where('archived = false')
        @entry = Entry.new
        @user = User.find(session[:id])
        @itinerary = Itinerary.new
        @itinerary.entries.build
        @review = Review.new
        @favorite = Favorite.new
        render :layout => "filter_page"
    end

    private
    def destination_params
        params.require(:destination).permit(:name, :city_id, :picture_link, events_attributes: [
            :name,
            :price
        ])
    end
end
