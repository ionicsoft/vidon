class SessionsController < ApplicationController
  def new
  end
  
  def create
    person = Person.find_by(username: params[:session][:username].downcase)
    if person && person.authenticate(params[:session][:password])
      log_in(person)
      redirect_to person.user
    else
      flash.now[:danger] = "No user found with username/password combination."
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
