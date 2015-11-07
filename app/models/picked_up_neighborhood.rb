class PickedUpNeighborhood < ActiveRecord::Base
  has_many :picked_up_locations
  belongs_to :neighborhood
end
