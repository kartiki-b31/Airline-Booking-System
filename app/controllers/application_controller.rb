class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :authorized
    helper_method :logged_in?
    helper_method :is_admin?

    helper_method :error_msg
    helper_method :set_error
    helper_method :is_error?


    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to root_path unless logged_in?
    end
    def is_admin?
        if  @current_user.nil?
            false
        else if
            @current_user.email=="admin@ncsu.edu"
                 true
             else
                 false
             end
        end
    end

    def set_error(error)
        @error=error
    end
    def error_msg
        @error
    end
    def is_error?
        if @error == " "
            false
        else
            true
        end
    end

    end

