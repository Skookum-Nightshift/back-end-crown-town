ActiveAdmin.register User do
  scope :active, default: true
  scope :clients
  scope :employee
  scope :all

  permit_params :id, :email, :first_name, :last_name, :password,
                :password_confirmation, :phone, :address_line_1, :address_line_2,
                :city, :state, :zip, :is_active, :role, :bucket_location,
                :total_compost_weight, :daily_compost_weight,
                user_neighborhoods_attributes: [:id, :neighborhood_id, :_destroy]

  index do
    selectable_column
    column :full_name
    column :email
    column :active
    column "Role" do |data|
      data.role.capitalize
    end
    column "Address" do |data|
      truncate(data.full_address)
    end
    column "Last Weight" do |data|
      data.daily_compost_weight
    end
    column :created_at
    actions
  end

  filter :name
  filter :active
  filter :email
  filter :role, as: :select, collection: [['Client', 'client'], ['Employee', 'employee']]
  filter :created_at
  filter :neighborhoods

  form do |f|
    f.inputs "User Details" do
      f.input :first_name, required: true
      f.input :last_name, required: true
      f.input :role, required: true, as: :select, collection: [['Client', 'client'], ['Employee', 'employee']]
      f.input :email, required: true
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
      f.input :is_active
    end
    f.inputs "Contact Details" do
      f.input :bucket_location, as: :select, collection: [['Front Door', 'FrontDoor'], ['Street Side', 'StreetSide']]
      f.input :phone
      f.input :address_line_1, required: true
      f.input :address_line_2
      f.input :city, required: true
      f.input :state, required: true
      f.input :zip, required: true
    end

    f.inputs "Weight Info" do
      f.input :total_compost_weight
      f.input :daily_compost_weight
    end

    f.inputs "Neighborhood Info" do
      f.has_many :user_neighborhoods, allow_destroy: true,
                new_record: "Add Neighborhood", heading: false do |neighborhood|
        neighborhood.input :neighborhood_id, label: "Neighborhood", as: :select, collection: Neighborhood.all
      end
    end
    f.actions
  end
end
