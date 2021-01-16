class ReviewsController < ApplicationController
    before_action :not_logged_in
    layout "filter_page"
    def index
        if params[:user_id]
            if User.find_by(id: params[:user_id]).nil?
                redirect_to User.find(session[:id])
            else
                # byebug
                @reviews = User.find(session[:id]).reviews
            end
        else  
             @reviews = User.find(session[:id]).reviews
        end
    end

    def create
        @review = Review.new(review_params)
        if @review.save
            redirect_to destination_path(@review.destination)
        else
            flash[:errors] = @review.errors.full_messages
            redirect_to destination_path(@review.destination)
        end
    end

    def edit
        @user = User.find(session[:id])
        if params[:user_id]
            if Review.find_by(id: params[:id], user_id: params[:user_id]).nil?
                flash[:alert] = ["Review not found"]
                # byebug
                redirect_to user_reviews_path(User.find(params[:user_id]))
            else
                @review = Review.find_by(id: params[:id], user_id: params[:user_id])
            end
        else 
            @review = Review.find(params[:id])
        end
    end 

    def update
        @user = User.find(session[:id])
        if params[:user_id]
            if Review.find_by(id: params[:id], user_id: params[:user_id]).nil?
                flash[:alert] = ["Review not found"]
                # byebug
                redirect_to user_reviews_path(User.find(params[:user_id]))
            else
                @review = Review.find_by(id: params[:id], user_id: params[:user_id])
            end
        else 
            @review = Review.find(params[:id])
        end
        if @review.update(review_params) 
            redirect_to user_reviews_path(@user)
        else
            # byebug
            flash[:errors] = @review.errors.full_messages
            redirect_to edit_user_review_path(@review.user, @review)
        end 
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to user_reviews_path(session[:id])
    end

    private
    def review_params
        params.require(:review).permit(:rating, :content, :user_id, :destination_id)
    end
end
