ActiveAdmin.register_page "Order Chart" do
  content do
    @metric = Cart.orders.where("created_at >= ?", Date.parse("3 January 2019")).group_by_day(:checked_out_at).count
    render partial: 'charts/orders', locals: { metric: @metric }
  end
end
