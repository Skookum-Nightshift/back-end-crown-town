class Api::V1::NeighborhoodsController < API::V1::BaseController

  before_action only: [ :needs_pick_up ] do
    require_proof authenticatable: :User
  end

  def index
    render json: Neighborhood.all #, serilizer: Api::V1::NeighborhoodSerializer, root: nil
  end

  def needs_pick_up
    location = current_user.neighborhoods.where( pickup_day: Time.now.strftime("%A") )
    if location
      render json: location, serilizer: Api::V1::NeighborhoodSerializer, root: nil
    else
      render json: { errors: ['no route found'] }, status: :unprocessable_entity
    end
  end

end
