ActiveAdmin.register Neighborhood do

permit_params :id, :npa_id, :pickup_day

form do |f|
	f.inputs do
		f.input :npa_id
		f.input :pickup_day, :collection => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
	end
	f.actions
end

end
