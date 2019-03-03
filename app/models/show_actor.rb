class ShowActor < ApplicationRecord
  belongs_to :show
  validates :name, presence: true
end
