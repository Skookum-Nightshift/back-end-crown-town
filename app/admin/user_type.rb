ActiveAdmin.register UserType do

permit_params :id, :name

form do |f|
	f.inputs do
		f.input :name, :collection => ['Admin', 'Employee', 'Customer']
	end
	f.actions
end

end
