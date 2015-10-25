class Api::V1::SessionSerializer < ActiveModel::Serializer

  attributes :email, :full_name, :user_id, :auth_token, :auth_token_expiration,
    :first_name, :last_name, :role, :routes

  attr_reader :token

  def user_id
    object.id
  end

  def full_name
    "#{object.first_name} #{object.last_name}".strip
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

  def routes
    if object.routes
      routes = []
      object.routes.each do |route|
        routes.push(Api::V1::RouteSerializer.new(route).attributes)
      end
      routes
    else
      []
    end
  end

end
