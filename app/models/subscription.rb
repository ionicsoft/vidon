class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :show
  validates :current_episode, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :default_episode

  def default_episode
    self.current_episode ||= 0
  end
  
  def next_episode
    show.episodes.find_by absolute_episode: current_episode
  end
  
  def next_video
    next_episode.video
  end
end
