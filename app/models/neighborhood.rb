class Neighborhood < ActiveRecord::Base
  geocoded_by :full_address
  after_validation :geocode

  has_many :user_neighborhoods
  has_many :users, through: :user_neighborhoods

  has_many :picked_up_locations

  def full_address
    "#{address_line_1}, #{address_line_2.length > 0 ? address_line_2+',' : ''} #{city} #{state}, #{zip}"
  end

  def display_name
    full_address
  end
end
