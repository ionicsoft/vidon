class ShowGenre < ApplicationRecord
  belongs_to :show
  validates :genre, presence: true
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    show.valid_producer?(producer)
  end
end
