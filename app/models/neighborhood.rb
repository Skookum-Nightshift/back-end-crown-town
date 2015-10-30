class Neighborhood < ActiveRecord::Base
  geocoded_by :full_address
  after_validation :geocode


  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  
  has_many :user_neighborhoods
  has_many :users, through: :user_neighborhoods


    def full_address
    "#{address_line_1}, #{city}, #{state}, #{zip}"
  end
end
