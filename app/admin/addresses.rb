ActiveAdmin.register Address do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
controller do
  def scoped_collection
    super.includes :cart
  end
end
permit_params :first_line, :second_line, :city, :postcode
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
