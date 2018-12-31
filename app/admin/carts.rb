ActiveAdmin.register Cart do
  # too broad
  controller do
    def scoped_collection
      super.includes :user, :address
    end
  end

  config.sort_order = "updated_at_desc"

  scope :all
  scope :orders, default: true

  # member_action :export do
  #   cart = Cart.find(params[:id])
  #   link_to "Export to CSV", export_admin_cart_path(cart), method: :get, format: "csv"
  # end

  member_action :print do
    amount = resource.amount
    address = resource.address
    cart_items = resource.cart_items
    date = resource.updated_at
    order_id = resource.order_id
    if amount && address && cart_items && date
      pdf = InvoicePdf.new(amount: amount, address: address, cart_items: cart_items, date: date, order_id: order_id)
      if order_id
        send_data pdf.render, filename: "receipt_#{order_id}.pdf"
      else
        send_data pdf.render, filename: "receipt.pdf"
      end
    else
      flash[:notice] = "Can't render invoice without address, amount, cart items and date"
      redirect_to admin_carts_path
    end
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
    column :name do |cart|
      cart.address&.full_name
    end
    column :cart_items do |cart|
      cart.basket
    end
    # column "Order?", :active do |cart| !cart.active? end
    column "Date of order", :updated_at do |cart|
      cart.updated_at.strftime("%a, %e %b %H:%M")
    end
    column :address do |cart|
      if cart.address
        cart.address.full_address
      else
        "No address has been added. (Payment not made)."
      end
    end
    column :email do |cart|
      cart.address&.email
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
      row "All items" do |cart|
        cart.cart_items.map {|item| "#{item.product.specific_name} x #{item.quantity}"}
      end
      row :address do |cart| cart.address.full_address end
      cart.cart_items.each do |item|
        row("#{item.product.specific_name}") {item.quantity}
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

