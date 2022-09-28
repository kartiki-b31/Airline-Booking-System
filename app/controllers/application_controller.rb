class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :authorized
    helper_method :logged_in?
    helper_method :is_admin?


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

    end

