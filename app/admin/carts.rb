ActiveAdmin.register Cart do
  controller do
    def csv_filename
      'Order Details.csv'
    end
  end

  scope :all
  scope :orders, default: true

  action_item :print, method: :get do
    if params[:id].present?
      cart = Cart.find(params[:id])
      link_to 'Print Invoice', print_admin_cart_path(cart)
    end
  end

  # member_action :export do
  #   cart = Cart.find(params[:id])
  #   link_to "Export to CSV", export_admin_cart_path(cart), method: :get, format: "csv"
  # end

  member_action :print, method: :get do
    pdf = InvoicePdf.new
    send_data pdf.render
  end

  index do
    selectable_column
    id_column
    column :amount, sortable: :amount do |cur|
      number_to_currency(cur.amount, unit: "£")
    end
    column :user do |cart|
      if cart.user.nil?
        "Guest user"
      else
        link_to "#{cart.user.id}", admin_user_path(cart.user)
      end
      # item "Guest", admin_user_path if user.nil?
    end
    column :cart_items do |cart|
      cart.cart_items.map {|item| "#{item.product.name} x #{item.quantity}"}
    end
    column "Orders", :active do |cart| !cart.active? end
    column :address do |cart|
      # raise
      if cart.user
        cart.user.addresses.order('id DESC').limit(1).first.full_address
      elsif cart.address
        cart.address.full_address
      else
        "No address has been added. (Payment not made)."
      end
    end
    actions name: "Actions"
    column {|cart| link_to 'Print Invoice', print_admin_cart_path(cart) }
    # column {|cart| link_to 'Export CSV', export_admin_cart_path(cart), format: "csv"}
  end


  show do
    attributes_table do
      row :id
      row "Order", :active do |cart| !cart.active? end
      row :created_at
      row :updated_at
      row :amount do |cart| number_to_currency(cart.amount, unit: "£") end
      row "Items" do |cart|
        cart.cart_items.map {|item| "#{item.product.name} x #{item.quantity}"}
      end
      cart.cart_items.each do |item|
        row("#{item.product.name}") {item.quantity}
      end
    end
    active_admin_comments
  end

  permit_params :user, :active, :created_at, :updated_at
    menu priority: 4

    filter :username
    filter :email
    filter :created_at


  csv force_quotes: true, column_names: true do
    column :address do |cart| cart.address.full_address if cart.address end
    column(:amount) do |cart| number_to_currency(cart.amount, unit: "£") end
    column "Items" do |cart|
      cart.cart_items.map {|item| "#{item.product.name} x #{item.quantity}"}.join(", ")
    end
  end
end
