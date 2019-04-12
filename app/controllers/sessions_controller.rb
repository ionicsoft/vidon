class SessionsController < ApplicationController
  # GET /login
  def new
  end
  
  # POST /login
  def create
    person = Person.find_by(username: params[:session][:username].downcase)
    if person && person.authenticate(params[:session][:password])
      log_in(person)
      params[:session][:remember_me] == '1' ? remember(person) : forget(person)
      redirect_to root_url
    else
      flash.now[:danger] = "No user found with username/password combination."
      render 'new'
    end
  end
  
  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
