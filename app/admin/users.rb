ActiveAdmin.register User do
  permit_params :email, :first_name, :second_name, :admin
  index do
    selectable_column
    column :id
    column :email
    column :name
    column :created_at
    column :admin
    actions
  end
end
