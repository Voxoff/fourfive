ActiveAdmin.register Product do
controller do
  def scoped_collection
    super.includes :product_group
  end
end
  permit_params :name, :price, :availability, :description, :strength
end
