class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
    # Check if person is logged in, else redirect
    def logged_in_any
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  
    # Check if customer is logged in, else redirect
    def logged_in_customer
      if logged_in?
        if current_person.producer?
          flash[:danger] = "Content not available for producers."
          redirect_back fallback_location: root_url
        end # Else customer is logged in and do nothing
      else
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Check if producer is logged in, else redirect
    def logged_in_producer
      if logged_in?
        if current_person.customer?
          flash[:danger] = "Content not available for customers."
          redirect_back fallback_location: root_url
        end # Else producer is logged in and do nothing
      else
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
