class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end
  
  def search
    if !params[:search].blank?  
      @parameter = params[:search].downcase  
      @show_results = Show.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
      @movie_results = Movie.joins(:video).search("%#{@parameter}%")
      @results = @show_results + @movie_results
    elsif !params[:fsearch].blank?
      friend_search
    else
      redirect_to(browse_path)
    end
  end
  
  def shows
  end
  
  def friends
    @friends = current_person.user.friends
    @requests = current_person.user.friend_requests
  end
  
  def friend_search
    @parameter = params[:fsearch].downcase
    @results = Customer.joins(:person).search("%#{@parameter}%")
  end

end
