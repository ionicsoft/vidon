class Episode < ApplicationRecord
  has_one :video
  belongs_to :show
end
