class StaticPagesController < ApplicationController
  #Authorization
  before_action :logged_in_customer, only: [:shows, :search, :friends, :friend_search]
  
  def home
    # Try to get videos to display on customer homepage
    if logged_in? and current_person.customer?
      # Try to get most recent video
      if current_person.user.watch_histories.any?
        # Get last watched video history
        recent_watch = current_person.user.watch_histories.order(updated_at: :desc).first
        # Generate suggestions based on last video watched
        s_genre = recent_watch.video.get_content_genres.first
        if s_genre.nil?
          # Last video doesn't have genre set, get 6 random shows
          @suggestions = random_shows
        else
          # Get 6 recently updated shows with same genre
          @suggestions = Show.with_attached_promo_image.order(updated_at: :desc).joins(:show_genres).where( show_genres: { genre: s_genre.genre } ).limit(6)
        end
        
        # Jumbotron video
        # 1. Continue watching
        if !recent_watch.completed
          @video = recent_watch.video
          @video_progress = recent_watch.progress
        else
          # 2. Next episode if available
          # might want to change to be episode.get(sub.current_ep).video if show.episodes >= sub.current_ep
          next_ep = recent_watch.video.next_video
          if !next_ep.nil?
            @video = next_ep
          else
            # 3. Next episode from random sub
            current_person.user.subscriptions.includes(:show).each do |sub|
              if sub.show.episodes.size > sub.current_episode
                @video = sub.show.episodes.find_by(absolute_episode: sub.current_episode+1).video
                break
              end
            end
          end
        end
        # 4. Nothing, link to browse page
      else
        # Customer not watched anything, random suggestions
        @suggestions = random_shows
      end
    end
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
    @friends = current_person.user.friends.includes(person: {avatar_attachment: :blob})
    @requests = current_person.user.friend_requests.includes(requester: { person: {avatar_attachment: :blob}})
  end
  
  def friend_search
    @parameter = params[:fsearch].downcase
    @results = Customer.joins(:person).search("%#{@parameter}%")
  end
  
  private
    def random_shows(num = 6)
      Show.with_attached_promo_image.offset(rand(Show.count - num + 1)).limit(num)
    end

end
