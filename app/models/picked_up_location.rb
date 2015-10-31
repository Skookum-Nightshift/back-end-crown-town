class PickedUpLocation < ActiveRecord::Base
  belongs_to :picked_up_neighborhood
  belongs_to :picked_up_location
end
