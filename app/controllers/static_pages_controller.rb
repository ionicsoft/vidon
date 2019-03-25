class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end
  
  def search
    if params[:search].blank?  
      redirect_to(shows_path) 
    else
      @parameter = params[:search].downcase  
      @show_results = Show.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
      @movie_results = Movie.joins(:video).search("%#{@parameter}%")
      @results = @show_results + @movie_results
    end
  end
  
  def friends
    @friends = Friend.all.where("customer_id LIKE :search", search: current_person)
    @requests = FriendRequest.all.where("customer_id LIKE :search", search: current_person)
  end
  
  def friend_search
    if params[:search].blank?
      redirect_to(friends_path)
    else
      @parameter = params[:search].downcase
      @results = Person.all.where("lower(username) LIKE :search", search: "%#{@parameter}%")
      redirect_to(search_page_path)
  end
  end
  
end
