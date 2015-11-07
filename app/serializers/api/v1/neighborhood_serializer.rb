class Api::V1::NeighborhoodSerializer < ActiveModel::Serializer
  attributes :neighborhood_id, :name, :npa_ids

  def neighborhood_id
    object.id
  end
end
