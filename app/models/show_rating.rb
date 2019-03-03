class ShowRating < ApplicationRecord
  belongs_to :show
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
