class StaticPagesController < ApplicationController
  #Authorization
  before_action :logged_in_customer, only: [:shows, :search, :friends, :friend_search]
  
  def home
  end

  def about
  end

  def contact
  end
  
  def search
    if !params[:search].blank?  
      parameter = params[:search].downcase
      show_results = Show.includes(:show_genres).where("lower(Shows.name) LIKE :search", search: "%#{parameter}%")
      movie_results = Movie.joins(:video).includes(:movie_genres).where("lower(videos.title) LIKE :search", search: "%#{parameter}%")
      
      # Filter search results
      if params[:filters]
        unless params[:filters][:genre].empty?
          # Convert "Genre title" into "genre_title"
          genre_param = params[:filters][:genre].parameterize.underscore
          # Genre filter
          show_results = show_results.joins(:show_genres).where(show_genres: { genre: genre_param } )
          movie_results = movie_results.joins(:movie_genres).where(movie_genres: { genre: genre_param } )
        end
        unless params[:filters][:actor].empty?
          # Actor search, case insensitive
          show_results = show_results.joins(:show_actors).where("lower(show_actors.name) LIKE ?", "%#{params[:filters][:actor]}%")
          movie_results = movie_results.joins(:movie_actors).where("lower(movie_actors.name) LIKE ?", "%#{params[:filters][:actor]}%")
        end
      end
      
      # Combine results
      @results = show_results + movie_results
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
