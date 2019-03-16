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
      @results = Video.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
    end
  end
end
