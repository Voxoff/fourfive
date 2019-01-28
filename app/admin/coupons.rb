ActiveAdmin.register Coupon do
  permit_params :code, :discount, :active

  # could refactor with a lambda :O ?
  batch_action "Activate" do |ids|
    batch_action_collection.find(ids).each do |coupon|
      coupon.activate
    end
    redirect_to collection_path, alert: "Those coupons have been activated."
  end

  batch_action "Deactivate" do |ids|
    batch_action_collection.find(ids).each do |coupon|
      coupon.deactivate
    end
    redirect_to collection_path, alert: "Those coupons have been deactivated."
  end

  # Don't want them to delete used coupons now do we?
  batch_action :destroy, false

  # nor individually
  actions :index, :show, :new, :create, :update, :edit, :view

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
      "£ #{c.amount}"
    end
    column :active
    actions defaults: true do |coupon|
      link_to 'Delete', admin_coupon_path(coupon), method: :delete unless coupon.used?
    end
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
