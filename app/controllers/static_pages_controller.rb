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
end
