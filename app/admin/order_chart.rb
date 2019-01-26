ActiveAdmin.register_page "Order Chart" do
  content do
    @metric = Cart.orders.group_by_day(:checked_out_at).count
    render partial: 'charts/orders', locals: { metric: @metric }
  end
end
