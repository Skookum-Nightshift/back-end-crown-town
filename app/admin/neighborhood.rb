ActiveAdmin.register Neighborhood do

permit_params :npa_id, :pickup_day, :address_line_1, :address_line_2, :city,
              :state, :zip

form do |f|
  f.inputs "Neighborhood Details" do
    f.input :npa_id
    f.input :pickup_day, collection: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'], required: true
  end
  f.inputs "Neighborhood Address" do
    f.input :address_line_1, required: true
    f.input :address_line_2
    f.input :city, required: true
    f.input :state, required: true
    f.input :zip, required: true
  end
  f.actions
end

end
