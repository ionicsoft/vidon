class ShowGenre < ApplicationRecord
  enum genre: {
    action: 0,
    adventure: 1,
    animation: 2,
    comedy: 3,
    crime: 4,
    drama: 5,
    educational: 6,
    fantasy: 7,
    game: 8,
    historical: 9,
    horror: 10,
    mystery: 11,
    political: 12,
    romance: 13,
    science_fiction: 14,
    thriller: 15,
    urban: 16,
    western: 17
  }
  
  belongs_to :show
  validates :genre, presence: true
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    show.valid_producer?(producer)
  end
end
