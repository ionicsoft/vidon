class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :show
  validates :current_episode, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :default_episode

  def default_episode
    self.current_episode ||= 0
  end
end
