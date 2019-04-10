class Episode < ApplicationRecord
  has_one :video, :as => :content
  belongs_to :show
  validates :season, presence: true, numericality: { greater_than: 0 }
  validates :episode, presence: true, numericality: { greater_than: 0 }
  validates :absolute_episode, presence: true, numericality: { greater_than: 0 }
  accepts_nested_attributes_for :video, allow_destroy: true
end
