class AccountActivationsController < ApplicationController
  def edit
    person = Person.find_by(email: params[:email])
    byebug
    if person && !person.activated? && person.authenticated?(:activation, params[:id])
      person.activate
      log_in person
      flash.notice = "Account activated!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
