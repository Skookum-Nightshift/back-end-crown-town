class Api::V1::UsersController < API::V1::BaseController

  before_action only: [ :update, :update_password, :cancel_pickup, :update_bucket_location ] do
    require_proof authenticatable: :User
  end

  def route_index
    render json: User.all, each_serializer: Api::V1::UserSerializer, root: nil
  end

  def update_weight
    message = "Updated weight"
    @user = User.find(params[:user_id])
    if params[:daily_compost_weight]
      total = (@user.total_compost_weight || 0) + params[:daily_compost_weight].to_i
      @user.update_attributes({daily_compost_weight: params[:daily_compost_weight].to_i, total_compost_weight: total})
    else
      message = "Missing daily_compost_weight param"
    end


    render json: { message: message }
  end


  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      NotificationMailer.account_change(@user).deliver_now
      render json: @user, serializer: Api::V1::SessionSerializer, root: nil
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(password_params)
      NotificationMailer.account_change(@user).deliver_now
      render json: @user, serializer: Api::V1::SessionSerializer, root: nil
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def cancel_pickup
    @user = User.find(current_user.id)
    if @user.update({can_pickup: !@user.can_pickup})
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_bucket_location
    @user = User.find(current_user.id)
    if @user.update(bucket_location: params[:bucket_location])
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, 
        :phone, :address_line_1, :address_line_2, 
        :city, :state, :zip, 
        :neighborhood_id, :user_type_id, :is_active,
        :bucket_location, :can_pickup, :daily_compost_weight, :total_compost_weight)
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
