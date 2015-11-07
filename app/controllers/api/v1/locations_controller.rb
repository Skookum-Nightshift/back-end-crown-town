class Api::V1::LocationsController < API::V1::BaseController

  before_action only: [ :next ] do
    require_proof authenticatable: :User
  end

  def next
    @location = get_next_location(params[:neighborhood_id])
    if @location
      PickedUpLocation.create({ pick_up_id: @location.id, user_id: current_user.id, picked_up_date: Date.today.to_s, neighborhood_id: params[:neighborhood_id] })
      render json: @location, serializer: Api::V1::LocationSerializer, root: nil
    else
      render json: { errors: ['no route found'] }, status: :unprocessable_entity
    end
  end

  private

    def get_next_location neighborhood_id, index=0
      places = Neighborhood.find(neighborhood_id).users.clients.near([params[:lat].to_f, params[:long].to_f], 5).to_a

      if index >= places.count
        return nil
      end

      return places[index] unless PickedUpLocation.where({user_id: current_user.id, pick_up_id: places[index].id, picked_up_date: Date.today.to_s}).count > 0
      get_next_location(neighborhood_id, index+1)
    end
end
