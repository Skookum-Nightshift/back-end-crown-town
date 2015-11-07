class Api::V1::LocationSerializer < ActiveModel::Serializer
  attributes :location_id, :address_line_1, :address_line_2, :city, :zip, :state,
             :latitude, :longitude, :bucket_location, :first_name, :last_name, :phone

  def location_id
    object.id
  end
end
