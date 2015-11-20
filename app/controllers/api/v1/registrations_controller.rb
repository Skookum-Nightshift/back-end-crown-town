class Api::V1::RegistrationsController < API::V1::BaseController
  require 'uri'
  require 'stripe'

  def create
    Stripe.api_key = ENV["STRIPE_SECRET"]

    token = params[:stripe_token]
    subscription = params[:subscription]

    stripe_customer = Stripe::Customer.create(
      :source => token,
      :plan => subscription,
      :email => user_params[:email],
      :description => "Customer for #{user_params[:first_name]} #{user_params[:last_name]}",
    )

    random_password = Devise.friendly_token.first(8)
    mapped_params = user_params
    mapped_params[:password] = random_password
    mapped_params[:password_confirmation] = random_password
    mapped_params[:stripe_id] = stripe_customer.id

    @user = User.new(mapped_params)
    if @user.save
      RegistrationMailer.welcome(@user, random_password).deliver_now
      render json: @user, serializer: Api::V1::SessionSerializer, root: nil
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :first_name, :last_name, :phone,
        :address_line_1, :address_line_2, :city, :state, :zip 
      )
    end
end
