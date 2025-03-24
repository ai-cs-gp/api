ActiveAdmin.register PartUsage do
  # Specify parameters which should be permitted for assignment
  permit_params :quantity, :price, :part_id, :solution_id

  # or consider:
  #
  # permit_params do
  #   permitted = [:quantity, :price, :part_id, :solution_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :quantity
  filter :price
  filter :part
  filter :solution
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :quantity
    column :price
    column :part
    column :solution
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :quantity
      row :price
      row :part
      row :solution
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :quantity
      f.input :price
      f.input :part
      f.input :solution
    end
    f.actions
  end
end
