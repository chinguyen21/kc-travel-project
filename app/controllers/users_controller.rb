
class UsersController < ApplicationController
  before_action :not_logged_in, only: :show
  layout "filter_page"
  
  def show
    @user = User.find(session[:id])
    render :layout => "my_account_page"
      
  end

  def welcome 
    render :layout => "welcome_page"
  end

  def new
    @user = User.new
    render :layout => "homepage" 
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to user_welcome_path(@user)
    else  
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end 
  end

    
    def edit
        @user = User.new
    end

    def update
        @user = User.find_by(session[:id])
        @itinerary.update(archived: true)
        redirect_to archived_user_itineraries_path(@itinerary.user)
    end
  private 
  def user_params 
    params.require(:user).permit(:name, :age, :email, :password, :password_confirmation)
  end
end
