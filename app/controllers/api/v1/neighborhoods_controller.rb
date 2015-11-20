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

  def get_geometries
    file = File.read("#{Rails.public_path}/npa/neighborhood_profile_areas.geojson")
    data_hash = JSON.parse(file)
    features = data_hash["features"]
    geometries = []

    Neighborhood.pluck(:npa_ids).each do |ids|

      split_ids = ids.split(',')

      split_ids.each do |id|
        geo_data = features.select{|hash| hash["properties"]["id"] == id.to_i }
     
        coordinates = geo_data[0]["geometry"]["coordinates"][0][0]

        geometries.push coordinates
      end
    end

    render json: geometries
  end

  def check_address
    address = "#{params[:line_one]}, #{params[:city]}, #{params[:state]}, #{params[:zip]}"
    puts address
    lat_long = Geocoder.coordinates(address)
    point = Geokit::LatLng.new(lat_long[0],lat_long[1])

    file = File.read("#{Rails.public_path}/npa/neighborhood_profile_areas.geojson")
    data_hash = JSON.parse(file)
    features = data_hash["features"]

    in_neighborhoods = false

    Neighborhood.pluck(:npa_ids).each do |ids|

      split_ids = ids.split(',')

      split_ids.each do |id|
        # get neighborhood definition
        puts id
        geo_data = features.select{|hash| hash["properties"]["id"] == id.to_i }
        # puts geo_data
        # turn into geokit points
        # binding.pry
        coordinates = geo_data[0]["geometry"]["coordinates"][0][0]
        # geo_points = coordinates.map {|point| Geokit::LatLng.new(point[0], point[1]) }

        # create geo kit polygon
        # polygon = Geokit::Polygon.new(geo_points)
        in_neighborhoods = point_in_polygon?(coordinates, lat_long[0], lat_long[1])
        
        break if in_neighborhoods
      end

      break if in_neighborhoods
end

render json: { valid_neighborhood: in_neighborhoods }

  end

private
  def point_in_polygon?(polygonPoints, lat, long)
    return false if lat.blank? or long.blank?
    polygonPoints.each do |point|
      point[0] = point[0].to_f
      point[1] = point[1].to_f
    end

    contains_point = false
    i = -1
    j = polygonPoints.size - 1
    while (i += 1) < polygonPoints.size
      a_point_on_polygon = polygonPoints[i]
      trailing_point_on_polygon = polygonPoints[j]
      if point_is_between_the_ys_of_the_line_segment?(a_point_on_polygon, trailing_point_on_polygon, lat, long)
        if ray_crosses_through_line_segment?(a_point_on_polygon, trailing_point_on_polygon, lat, long)
          contains_point = !contains_point
        end
      end
      j = i
    end
    contains_point
  end

  def point_is_between_the_ys_of_the_line_segment?(a_point_on_polygon, trailing_point_on_polygon, lat, long)
    (a_point_on_polygon[0] <= lat && lat < trailing_point_on_polygon[0]) || 
    (trailing_point_on_polygon[0] <= lat && lat < a_point_on_polygon[0])
  end

  def ray_crosses_through_line_segment?(a_point_on_polygon, trailing_point_on_polygon)
    (long < (trailing_point_on_polygon[1] - a_point_on_polygon[1]) * (lat - a_point_on_polygon[0]) / 
    (trailing_point_on_polygon[0] - a_point_on_polygon[0]) + a_point_on_polygon[1])
  end

end
