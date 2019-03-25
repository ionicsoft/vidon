class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :show
  validates :current_episode, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :defaults_set

  def defaults_set
    self.current_episode ||= 0
    self.cancel ||= false
  end
  
  def next_episode
    show.episodes.find_by absolute_episode: current_episode
  end
  
  def next_video
    next_episode.video
  end
end
