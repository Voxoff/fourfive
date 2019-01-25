ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active

  index do
    selectable_column
    id_column
    column :code
    column "Discount" do |coupon|
      coupon.discount.to_s + "%"
    end
    column "No. of orders" do |coupon|
      coupon.carts.orders.count
    end
    column "Money spent/saved on coupons" do |c|
      (c.carts.orders.map(&:amount).reduce(:+) * c.percent) unless c.carts.orders.empty?
    end
    column :active
    # column "No. of carts (not all checked out)" do |coupon|
    #   coupon.carts.count
    # end
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :code
      f.input :discount, label: "Discount,  FORMAT: XX(%)"
      f.input :active, label: "Active? (I.e. Live?)"
    end
    f.button :Submit
  end
end
