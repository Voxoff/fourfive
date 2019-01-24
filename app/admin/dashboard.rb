ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Stock Sold" do
          cart_item = CartItem.joins(:cart).merge(Cart.orders)
          table do
            thead do
              tr do
                th do
                  "Date"
                end
                Product.order(:id).map(&:specific_name).each &method(:th)
              end
            end
            tbody do
              # create a row for each week.
              tr do
                (1..Product.count).to_a.each_with_index do |id, i|
                  td do "2 weeks ago" end if i == 0
                  td do
                    cart_item.joins(:product).merge(Product.where(id: id)).merge(Cart.weeks_ago(2)).count
                  end
                end
              end
              tr do
                (1..Product.count).to_a.each_with_index do |id, i|
                  td do "Total sold" end if i == 0
                  td do
                    cart_item.joins(:product).merge(Product.where(id: id)).count
                  end
                end
              end
            end
          end
        end
      end

      column do
        panel "Last 10 Orders" do
          table_for Cart.includes(:address, cart_items: :product).orders.last(10).reverse do
            column("Customer name") { |cart| link_to(cart.address&.full_name, admin_cart_path(cart)) }
            column("Total") { |cart| number_to_currency(cart.amount, unit: "£") }
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
          # div do
          #   Cart.includes(:address).orders.limit(10).each{|i| i.cart_items.product}
          # end
        end
      end
    end
  end
end
