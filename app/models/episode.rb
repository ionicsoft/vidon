class Episode < ApplicationRecord
  has_one :video, :as => :content
  belongs_to :show
  validates :season, presence: true, numericality: { greater_than: 0 }
  validates :episode, presence: true, numericality: { greater_than: 0 }
  validates :absolute_episode, presence: true, numericality: { greater_than: 0 }
  
  def season_episode
    "Season #{season}, Ep. #{episode}"
  end
  
end
