ActiveAdmin.register User do
  permit_params :email, :first_name, :second_name, :admin

  # filter :email
  # filter :full_name
  menu priority: 4

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    column :admin
    actions
  end

  show title: :first_name do
    panel "Order History" do
      table_for(user.orders) do

        column("Order", sortable: :id) do |cart|
          link_to "Order", admin_cart_path(cart)
        end
        # column("State") { |cart| status_tag(cart.state) }
        column("Date", sortable: :updated_at) do |cart|
          pretty_format(cart.updated_at)
        end
        column("Total") { |cart| number_to_currency(cart.amount, unit: "£") }
      end
    end

    panel "Address Book" do
      table_for(user.carts.includes(:address)) do
        column("Address") do |cart|
          if cart.address
            div cart.address.first_line
            div cart.address.second_line
            div cart.address.city
            div cart.address.postcode
          end
        end
        column :city do |cart| cart.address.city if cart.address end
        column :postcode do |cart| cart.address.postcode if cart.address end
      end
    end
    active_admin_comments
  end
end
