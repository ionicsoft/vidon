module SessionsHelper
  
  # Logs in the given person
  def log_in(person)
    session[:person_id] = person.id
  end
  
  # Remembers the given person in a persistant session
  def remember(person)
    person.remember
    cookies.permanent.signed[:person_id] = person.id
    cookies.permanent[:remember_token] = person.remember_token
  end
  
  # Returns true if the given user is the current user. User can be a customer or producer
  def current_user?(user)
    user == current_person.user
  end
  
  # Returns the logged in person using token cookie
  def current_person
    if (person_id = session[:person_id])
      @current_person ||= Person.find_by(id: person_id)
    elsif (person_id = cookies.signed[:person_id])
      person = Person.find_by(id: person_id)
      if person && person.authenticated?(cookies[:remember_token])
        log_in person
        @current_person = person
      end
    end
  end
  
  # Returns true if a person is logged in
  def logged_in?
    !current_person.nil?
  end
  
  # Forget persistant session
  def forget(person)
    person.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Logs out the current person
  def log_out
    forget(current_person)
    session.delete(:person_id)
    @current_person = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
