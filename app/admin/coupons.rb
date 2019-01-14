ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active

  index do |coupon|
    selectable_column
    id_column
    column :code
    column "Times used" do |coupon|
      # coupon.carts.count
    end
  end
end
