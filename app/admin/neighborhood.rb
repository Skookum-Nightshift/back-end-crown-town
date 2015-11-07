ActiveAdmin.register Neighborhood do

  permit_params :npa_ids, :pickup_day, :name

  filter :name
  filter :pickup_day, as: :select, collection: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  filter :npa_ids

  index do
    selectable_column
    column :name
    column :pickup_day
    column :npa_ids
    actions
  end

  form do |f|
    f.inputs "Neighborhood Details" do
      f.input :name, required: true
      f.input :npa_ids, required: true
      f.input :pickup_day, collection: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'], required: true
    end
    f.actions
  end

end
