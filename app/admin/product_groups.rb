ActiveAdmin.register ProductGroup do
  permit_params :help, :ingredients, :how_to_use, :description, :subtitle
  menu priority: 3

end
