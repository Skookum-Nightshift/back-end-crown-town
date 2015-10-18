ActiveAdmin.register Announcement do

permit_params :id, :message, :user_id
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
		f.input :message
		# Want to make it so only Admin Users will show up in this dropdown
		f.input :user, collection => User.all.map{|user| [user.first_name, user.id]}
	end
	f.actions
end

end
