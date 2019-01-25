ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active

  index do
    selectable_column
    id_column
    column :code
    column "No. of orders" do |coupon|
      coupon.carts.orders.count
    end
    column "Discount" do |coupon|
      coupon.discount.to_s + "%"
    end
    column "Money spent on coupons" do |c|
      (c.carts.orders.map(&:amount).reduce(:+) * c.percent) unless c.carts.orders.empty?
    end
    column "No. of carts" do |coupon|
      coupon.carts.count
    end
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :code
      f.input :discount
      f.input :active
    end
    f.button :Submit
  end
end
