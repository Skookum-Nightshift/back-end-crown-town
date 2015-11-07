class Api::V1::RouteSerializer < ActiveModel::Serializer
  attributes :route_id, :address_line_1, :address_line_2, :city, :zip, :state, :latitude, :longitude

  def route_id
    object.id
  end
end