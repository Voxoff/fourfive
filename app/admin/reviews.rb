ActiveAdmin.register Review do
  controller do
    def scoped_collection
      super.includes :user, :product
    end
  end

  index do
    selectable_column
    column :id
    column :product
    column :user
    column :name
    column :position
    column :content
    column :photo
    column :updated_at
    actions
  end
end
