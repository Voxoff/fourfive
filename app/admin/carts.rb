ActiveAdmin.register Cart do

  scope :all
  scope :orders

  permit_params :user, :active, :created_at, :updated_at

end
