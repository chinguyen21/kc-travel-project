class FavoritesController < ApplicationController
    before_action :not_logged_in
    layout "filter_page"
    def index
        if params[:user_id]
            if User.find_by(id: params[:user_id]).nil?
                redirect_to User.find(session[:id])
            else
                @favorites = User.find(session[:id]).favorites
            end
        else  
             @favorites = User.find(session[:id]).favorites
        end
    end

    def create
        # byebug
        @favorite = Favorite.create(favorite_params)
        redirect_to destination_path(@favorite.destination)
    end

    private
    def favorite_params
        params.require(:favorite).permit(:user_id, :destination_id)
    end
end
