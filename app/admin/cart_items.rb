ActiveAdmin.register CartItem do

  controller do
    def scoped_collection
      super.includes :cart, :product
    end
  end
  permit_params :cart, :user, :product

end
