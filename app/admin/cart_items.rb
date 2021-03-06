ActiveAdmin.register CartItem do
  controller do
    def scoped_collection
      super.includes :cart, :product
    end
  end
  menu priority: 4

  permit_params :quantity
end
