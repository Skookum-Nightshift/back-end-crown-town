class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :user_id, :full_name, :first_name, :last_name, :email, :role,
             :bucket_location, :can_pickup

  def user_id
    object.id
  end

  def full_name
    object.name
  end

end
