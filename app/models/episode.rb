class Episode < ApplicationRecord
  belongs_to :show
  has_one :video, as: :content
  has_many :favorites, as: :content, dependent: :destroy
  
  validates :season, presence: true, numericality: { greater_than: 0 }
  validates :episode, presence: true, numericality: { greater_than: 0 }
  validates :absolute_episode, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :video, allow_destroy: true
  
  def season_episode
    "Season #{season}, Ep. #{episode}"
  end
end
