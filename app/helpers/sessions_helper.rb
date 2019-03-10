module SessionsHelper
  def log_in(person)
    session[:person_id] = person.id
  end
  
  def current_person
    if session[:person_id]
      @current_person ||= Person.find_by(id: session[:person_id])
    end
  end
  
  def logged_in?
    !current_person.nil?
  end
  
  def log_out
    session.delete(:person_id)
    @current_person = nil
  end
end
