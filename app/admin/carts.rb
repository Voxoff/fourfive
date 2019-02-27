ActiveAdmin.register Cart do
  # too broad
  filter :address_first_name, as: :string
  filter :address_last_name, as: :string
  filter :address_postcode, as: :string
  filter :address_email, as: :string
  filter :created_at

  scope :all
  scope :orders
  scope :unfulfilled, default: true
  scope :fulfilled

  menu priority: 2

  controller do
    def scoped_collection
      super.includes :user, :address
    end
  end

  config.sort_order = "checked_out_at_asc"
  config.per_page = [30, 100, 200]

  member_action :print do
    amount = resource.amount
    address = resource.address
    cart_items = resource.cart_items
    date = resource.updated_at
    order_id = resource.order_id
    coupon = resource.coupon
    if amount && address && cart_items && date
      pdf = InvoicePdf.new(amount: amount, address: address, cart_items: cart_items, date: date, order_id: order_id, coupon: coupon)
      if order_id
        send_data pdf.render, filename: "receipt_#{order_id}.pdf"
        GC.start
      else
        send_data pdf.render, filename: "receipt.pdf"
      end
    else
      flash[:notice] = "Can't render invoice without address, amount, cart items and date"
      redirect_to admin_carts_path
    end
  end

  batch_action :fulfill do |ids|
    batch_action_collection.find(ids).each do |cart|
      cart.fulfill!
    end
    redirect_to collection_path, alert: "The carts have been marked as fulfilled."
  end

  index do |cart|
    selectable_column
    id_column
    column :amount do |cur|
      number_to_currency(cur.amount, unit: "£")
    end
    column :user do |cart|
      if cart.user.nil?
        "Guest user"
      else
        link_to "#{cart.user.id}", admin_user_path(cart.user)
      end
    end
    column :name do |cart|
      cart.address&.full_name
    end
    column :cart_items do |cart|
      cart.basket
    end
    column "Date of order", :updated_at do |cart|
      cart.checked_out_at ? cart.checked_out_at.strftime("%a, %e %b %H:%M") : cart.updated_at.strftime("%a, %e %b %H:%M")
    end
    column :address do |cart|
      if cart.address
        cart.address.full_address
      else
        "No address has been added. (Payment not made)."
      end
    end
    column :coupon do |cart|
      if cart.coupon
        cart.coupon.code
      else
        "No coupon used."
      end
    end
    column :email do |cart|
      cart.address&.email
    end
    actions name: "Actions"
    column do |cart|
      link_to 'Print Invoice', cart.receipt.url || print_admin_cart_path(cart), target:"_blank"
    end
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
      row :address do |cart| cart.address&.full_address end
      cart.cart_items.each do |item|
        row("#{item.product.specific_name}") {item.quantity}
      end
    end
    active_admin_comments
  end

  # permit_params :user, :active, :created_at, :updated_at, :address_email

  csv force_quotes: true, column_names: true do
    column :address do |cart| cart.address.full_address if cart.address end
    column(:amount) do |cart| number_to_currency(cart.amount, unit: "£") end
    column "Items" do |cart|
      cart.cart_items.map {|item| "#{item.product.name} x #{item.quantity}"}.join(", ")
    end
  end
end

