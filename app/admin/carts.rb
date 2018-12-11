ActiveAdmin.register Cart do

  scope :all
  scope :orders, default: true

  action_item :print, method: :get do
    if params[:id].present?
      cart = Cart.find(params[:id])
      link_to 'Print Invoice', print_admin_cart_path(cart)
    end
  end

  member_action :print, method: :get do
    pdf = InvoicePdf.new
    send_data pdf.render
  end

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
      if cart.user
        cart.user.addresses.order('id DESC').limit(1)
      else
        cart.address
      end
    end
    actions name: "Actions"
    column {|cart| link_to 'Print Invoice', print_admin_cart_path(cart) }
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
