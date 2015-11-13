class Api::V1::SessionSerializer < ActiveModel::Serializer

  attributes :email, :full_name, :user_id, :auth_token, :auth_token_expiration,
    :first_name, :last_name, :role, :bucket_location,
    :can_pickup, :daily_compost_weight, :total_compost_weight

  attr_reader :token

  def user_id
    object.id
  end

  def full_name
    object.full_name
  end

  def token
    expiration_date = 1.day.from_now.to_i
    secret = Rails.application.secrets.secret_key_base
    @token ||= Proof::Token.from_data({ user_id: object.id }, secret, 'HS256', expiration_date)
  end

  def auth_token
    token.token
  end

  def auth_token_expiration
    token.expiration_date * 1000
  end

end
