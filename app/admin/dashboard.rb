ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Sign ups" do
          table_for User.not_guests.order("id desc").limit(10).each do |_user|
            column(:email) { |user| link_to(user.email, admin_user_path(user)) }
            column(:name) { |user| link_to(user.first_name + " " +   user.last_name, admin_user_path(user)) }
          end
        end
      end

      column do
        panel "Recent Orders" do
          table_for Cart.orders.has_user.limit(10) do
            column("Customer") { |order| link_to(order.user, admin_user_path(order.user)) }
            column("Total") { |order| number_to_currency order.amount }
          end
        end
      end
    end

    columns do
      column do
        panel "ActiveAdmin Demo" do
          div do
            link_to("All current orders", admin_carts_path)
          end
        end
      end

      column do
        panel "Last 24 hours" do
          div do
            Cart.orders.has_user.map(&:amount).reduce(:+)
          end
          div do
            # Cart.orders.has_user.
          end
        end
      end
    end
  end
end
