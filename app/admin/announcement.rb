ActiveAdmin.register Announcement do

permit_params :id, :message, :user_id

form do |f|
	f.inputs do
		f.input :message
		# Want to make it so only Admin Users will show up in this dropdown
		f.input :user, collection => User.all.map{|user| [user.name, user.id]}
	end
	f.actions
end

end
