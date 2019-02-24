ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  # member_action :print_stock do
  #   puts 'print'
  # end
  # actions :print_stock
  controller do
    def print_stock
      puts "asdf"
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Stock Sold" do
          render 'admin/stock_table'
        end
      end

      column do
        panel "Last 30 Orders" do
          table_for Cart.includes(:address, :coupon, cart_items: :product).orders.last(30).reverse do
            column("Customer name") { |cart| link_to(cart.address&.full_name, admin_cart_path(cart)) }
            # to make sure SQL is efficient
            column("Total") { |cart| number_to_currency(cart.amount(without_includes: true), unit: "£") }
            column("Created at") {|c| c.checked_out_at ? c.checked_out_at.strftime("%A, %b %d %H:%M") : c.updated_at.strftime("%A, %b %d %H:%M") }
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
        panel "Total Revenue" do
          div do
            number_to_currency(Cart.revenue, unit: "£")
          end
        end
      end
    end
  end
end
