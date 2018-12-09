ActiveAdmin.register Cart do

  scope :all
  scope :orders

  index do
    selectable_column
    id_column
    column :amount
    column :user
    column :active
    column :created_at
    column :update_at
    actions
  end


  permit_params :user, :active, :created_at, :updated_at
    menu priority: 4
    config.batch_actions = true

    filter :username
    filter :email
    filter :created_at

    permit_params :username, :email, :password

    index do
      selectable_column
      id_column
      column :username
      column :email
      column :created_at
      actions
    end



end
