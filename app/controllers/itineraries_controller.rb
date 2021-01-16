class ItinerariesController < ApplicationController
    before_action :not_logged_in
    layout "nav_page"
    def index
        if params[:user_id]
            if User.find_by(id: params[:user_id]).nil?
                redirect_to User.find(session[:id])
            else
                @itineraries = User.find(session[:id]).itineraries.where('archived = false')
            end
        else  
             @itineraries = User.find(session[:id]).itineraries
        end
    end

    def show
        @user = User.find(session[:id])
        if params[:user_id]
            if Itinerary.find_by(id: params[:id], user_id: params[:user_id]).nil?
                flash[:alert] = ["Itinerary not found"]
                redirect_to user_itinerarys_path(User.find(params[:user_id]))
            else
                @itinerary = Itinerary.find_by(id: params[:id], user_id: params[:user_id])
            end
        else 
            @itinerary = Itinerary.find(params[:id])
        end
    end


    def new
        @itinerary = Itinerary.new
        @itinerary.entries.build
    end

    def create
        @itinerary = Itinerary.new(itinerary_params)
        if @itinerary.save
            redirect_to @itinerary 
        else
            flash[:errors] = @itinerary.errors.full_messages
            redirect_to new_itinerary_path
        end
    end

    def update 
        @itinerary = Itinerary.find(params[:id])
        @itinerary.update(archived: true)
        redirect_to archived_user_itineraries_path(@itinerary.user)
    end

    def archived
        if params[:user_id]
            if User.find_by(id: params[:user_id]).nil?
                redirect_to User.find(session[:id])
            else
                @itineraries = User.find(session[:id]).itineraries.where('archived = true')
            end
        else  
             @itineraries = User.find(session[:id]).itineraries
        end
    end

    def archive 
        @itinerary = Itinerary.find(params[:id])
        @itinerary.update(archived: true)
        redirect_to archived_user_itineraries_path(@itinerary.user)
    end
    
    private
    def itinerary_params
        params.require(:itinerary).permit(:name, :user_id, entries_attributes: [
            :date,
            :event_id
        ])
    end
end
