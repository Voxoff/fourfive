ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Sign ups" do
          table_for User.not_guests.order("id desc").limit(10).each do |_user|
            column(:email) { |user| link_to(user.email, admin_user_path(user)) }
            column(:created_at)
            # if user.first_name && user.last_name
            #   column(:name) { |user| link_to(user.full_name, admin_user_path(user)) }
            # end
          end
        end
      end

      column do
        panel "Recent Orders" do
          table_for Cart.orders.limit(10) do
            # column("Customer") { |cart| link_to(cart.user.email, admin_user_path(cart.user)) }
            column("Customer name") { |cart| link_to(cart.address&.full_name, admin_cart_path(cart)) }
            column("Total") { |cart| number_to_currency(cart.amount, unit: "£") }
            column("Created at") {|c| c.created_at.strftime("%A, %b %d") }
            column("Basket", &:basket)
          end
        end
      end
    end

    columns do
      column do
        panel "Useful Links" do
          div do
            link_to("All current orders", admin_carts_path)
          end
        end
      end

      column do
        panel "Last 24 hour Revenue" do
          div do
            amount = Cart.orders.has_user.map(&:amount).compact.reduce(:+)
            number_to_currency(amount, unit: "£")
          end
        end
      end
    end
  end
end
