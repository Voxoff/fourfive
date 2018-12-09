ActiveAdmin.register User do
  permit_params :email, :first_name, :second_name, :admin

  # filter :email
  # filter :full_name

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
        column("Order", sortable: :id) do |order|
          link_to "##{order.id}", admin_order_path(order)
        end
        # column("State") { |order| status_tag(order.state) }
        column("Date", sortable: :checked_out_at) do |order|
          pretty_format(order.checked_out_at)
        end
        column("Total") { |order| number_to_currency order.amount }
      end
    end

    panel "Address Book" do
      table_for(user.addresses) do
        column("Fullname") do |a|
          a.user.full_name
        end
        column("Address") do |a|
          div a.first_line
          div a.second_line
          div a.city
          div a.postcode
        end
        column :city
        column :postcode
      end
    end
    active_admin_comments
  end
end
