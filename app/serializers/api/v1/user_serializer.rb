class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :user_id, :full_name, :first_name, :last_name, :email, :role,
             :bucket_location, :can_pickup, :daily_compost_weight, :total_compost_weight

  def user_id
    object.id
  end

  def full_name
    object.full_name
  end

end
