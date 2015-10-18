ActiveAdmin.register UserType do

permit_params :id, :name
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form do |f|
	f.inputs do
		f.input :name, :collection => ['Admin', 'Employee', 'Customer']
	end
	f.actions
end

end
