ActiveAdmin.register Cart do

  scope :all
  scope :orders, default: true

  index do
    selectable_column
    id_column
    column :amount
    column :user do |cart|
      "Guest user" if cart.user.nil?
      # item "Guest", admin_user_path if user.nil?
    end
    column "Orders", :active do |cart|
      !cart.active?
    end
    column :address do |cart|
      cart.user.addresses.order('id DESC').limit(1)
    end
    # column :created_at
    # column :updated_at
    actions name: "Actions"
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
