ActiveAdmin.register FixingCar do
  # Specify parameters which should be permitted for assignment
  permit_params :state, :started_at, :finished_at, :car_id, :technician_id

  # or consider:
  #
  # permit_params do
  #   permitted = [:state, :started_at, :finished_at, :car_id, :technician_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :state
  filter :started_at
  filter :finished_at
  filter :car
  filter :technician
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :state
    column :started_at
    column :finished_at
    column :car
    column :technician
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :state
      row :started_at
      row :finished_at
      row :car
      row :technician
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :state
      f.input :started_at
      f.input :finished_at
      f.input :car
      f.input :technician
    end
    f.actions
  end
end
