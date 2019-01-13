ActiveAdmin.register Address do
  # n + 1 query
  controller do
    def scoped_collection
      super.includes :cart
    end
  end
  menu priority: 3

  permit_params :first_line, :second_line, :third_line, :first_name, :last_name, :phone_number, :country, :salutation, :city, :postcode, :email
end
