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
    @friends = Friend.all
  end
  
  def friend_search
    if params[:search].blank?
      redirect_to(friends_path)
    else
      @results = Customer.joins(:person).search("%#{@parameter}%")
    end
  end
  
  def friend_requests
    @requests = FriendRequest.all
  end
  
  def add_friend
    @userID = current_person.person_id
  end
  
end
