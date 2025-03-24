ActiveAdmin.register Part do
  # Specify parameters which should be permitted for assignment
  permit_params :name, :description, :brand, :model, :year, :member_id

  # or consider:
  #
  # permit_params do
  #   permitted = [:name, :description, :brand, :model, :year, :member_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :name
  filter :description
  filter :brand
  filter :model
  filter :year
  filter :member
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :brand
    column :model
    column :year
    column :member
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :name
      row :description
      row :brand
      row :model
      row :year
      row :member
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :description
      f.input :brand
      f.input :model
      f.input :year
      f.input :member
    end
    f.actions
  end
end
