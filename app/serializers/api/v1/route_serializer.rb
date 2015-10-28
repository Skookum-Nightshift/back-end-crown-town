class Api::V1::RouteSerializer < ActiveModel::Serializer
  attributes :route_id, :address, :city, :zipcode, :state

  def route_id
    object.id
  end
end