class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :user_id, :full_name, :first_name, :last_name, :email, :role,
             :bucket_location, :can_pickup, :daily_compost_weight, :total_compost_weight

  has_many :user_neighborhoods
  has_many :neighborhoods, through: :user_neighborhoods

  def user_id
    object.id
  end

  def full_name
    object.full_name
  end

end
