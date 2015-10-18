ActiveAdmin.register User do
  scope :active, default: true
  scope :all

  permit_params :id, :email, :first_name, :last_name, :password, :password_confirmation, :phone, :address_line_1, :address_line_2, :city, :state, :zip, :neighborhood_id, :user_type_id, :is_active

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :active
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :active
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :phone
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :state
      f.input :zip
      f.input :neighborhood, collection => Neighborhood.all.order(npa_id: :asc).map{ |n| [n.npa_id, n.id]}
      f.input :user_type, collection => UserType.all.map{ |type| [type.name, type.id]}
      f.input :is_active
    end
    f.actions
  end
end
