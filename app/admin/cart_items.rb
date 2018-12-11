ActiveAdmin.register CartItem do
  permit_params :cart, :user, :product
end
