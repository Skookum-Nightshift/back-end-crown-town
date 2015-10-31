class Api::V1::LocationsController < API::V1::BaseController

  before_action only: [ :next ] do
    require_proof authenticatable: :User
  end

  def next
    location = get_next_location(get_next_neiborhood.id)
  end

  private
    def get_next_neiborhood index=0
      places = current_user.neighborhoods.where( pickup_day: Time.now.strftime("%A") ).near([params[:lat], params[:long]], 5, order: :distance, units: :miles)
      return places[index] # unless PickedUpNeighborbood.where( date: Date.now, neigborhood_id: places[index].id ).picked_up_locations.count == places[index].users.clients.count
      get_next_neiborhood(index+1)
    end

    def get_next_location neiborhood_id index=0
      places = Neighborhood.find(neiborhood_id).users.clients.near([params[:lat], params[:long]], 5, order: :distance, units: :miles)
      return places[index] # unless PickedUpLocation.where( user_id: places[index].id )
      get_next_neiborhood(neiborhood_id, index+1)
    end
end