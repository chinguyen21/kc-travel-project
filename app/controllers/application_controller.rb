class ApplicationController < ActionController::Base
    def current_user
        User.find_by(id: session[:id])
    end

    def logged_in?
        !!current_user
    end

    def not_logged_in
        redirect_to welcome_path unless logged_in?
    end
end
