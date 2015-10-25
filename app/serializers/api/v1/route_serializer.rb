class Api::V1::RouteSerializer < ActiveModel::Serializer
  attributes :address, :city, :zipcode, :state
end