class Episode < ApplicationRecord
  belongs_to :show, touch: true
  has_one :video, as: :content
  has_many :favorites, as: :content, dependent: :destroy
  
  validates :season, presence: true, numericality: { greater_than: 0 }
  validates :episode, presence: true, numericality: { greater_than: 0 }
  validates :absolute_episode, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :video, update_only: true
  
  # Returns a formatted string describing the season and episode
  def season_episode
    "Season #{season}, Ep. #{episode}"
  end
  
  # Returns the next episode in the series if it exists
  def next_ep
    Episode.find_by(show_id: show_id, absolute_episode: absolute_episode+1)
  end
  
  # Returns the previous episode in the series if it exists
  def prev_ep
    Episode.find_by(show_id: show_id, absolute_episode: absolute_episode-1)
  end
    
  def valid_producer?(producer)
    show.valid_producer?(producer)
  end
end
