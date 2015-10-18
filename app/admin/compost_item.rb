ActiveAdmin.register CompostItem do

permit_params :id, :name, :disposal_type

form do |f|
	f.inputs do
		f.input :name
		f.input :disposal_type, :collection => ['Trash', 'Recycle', 'Compost']
	end
	f.actions
end

end
