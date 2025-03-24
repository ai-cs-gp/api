ActiveAdmin.register Users::Technician do
  # Specify parameters which should be permitted for assignment
  permit_params :type, :email, :phone, :password_digest, :impersonation_password_digest, :reset_password_otp, :reset_password_otp_sent_at, :email_otp, :email_otp_sent_at, :email_verified_at, :phone_otp, :phone_otp_sent_at, :phone_verified_at, :banned_at, :ban_reason, :banned_by_id, :locale, :first_name, :last_name, :gender, :dob, :devices, :metadata

  # or consider:
  #
  # permit_params do
  #   permitted = [:type, :email, :phone, :password_digest, :impersonation_password_digest, :reset_password_otp, :reset_password_otp_sent_at, :email_otp, :email_otp_sent_at, :email_verified_at, :phone_otp, :phone_otp_sent_at, :phone_verified_at, :banned_at, :ban_reason, :banned_by_id, :locale, :first_name, :last_name, :gender, :dob, :devices, :metadata]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :type
  filter :email
  filter :phone
  filter :password_digest
  filter :impersonation_password_digest
  filter :reset_password_otp
  filter :reset_password_otp_sent_at
  filter :email_otp
  filter :email_otp_sent_at
  filter :email_verified_at
  filter :phone_otp
  filter :phone_otp_sent_at
  filter :phone_verified_at
  filter :banned_at
  filter :ban_reason
  filter :banned_by
  filter :locale
  filter :first_name
  filter :last_name
  filter :gender
  filter :dob
  filter :devices
  filter :metadata
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :type
    column :email
    column :phone
    column :password_digest
    column :impersonation_password_digest
    column :reset_password_otp
    column :reset_password_otp_sent_at
    column :email_otp
    column :email_otp_sent_at
    column :email_verified_at
    column :phone_otp
    column :phone_otp_sent_at
    column :phone_verified_at
    column :banned_at
    column :ban_reason
    column :banned_by
    column :locale
    column :first_name
    column :last_name
    column :gender
    column :dob
    column :devices
    column :metadata
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :type
      row :email
      row :phone
      row :password_digest
      row :impersonation_password_digest
      row :reset_password_otp
      row :reset_password_otp_sent_at
      row :email_otp
      row :email_otp_sent_at
      row :email_verified_at
      row :phone_otp
      row :phone_otp_sent_at
      row :phone_verified_at
      row :banned_at
      row :ban_reason
      row :banned_by
      row :locale
      row :first_name
      row :last_name
      row :gender
      row :dob
      row :devices
      row :metadata
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :type
      f.input :email
      f.input :phone
      f.input :password_digest
      f.input :impersonation_password_digest
      f.input :reset_password_otp
      f.input :reset_password_otp_sent_at
      f.input :email_otp
      f.input :email_otp_sent_at
      f.input :email_verified_at
      f.input :phone_otp
      f.input :phone_otp_sent_at
      f.input :phone_verified_at
      f.input :banned_at
      f.input :ban_reason
      f.input :banned_by
      f.input :locale
      f.input :first_name
      f.input :last_name
      f.input :gender
      f.input :dob
      f.input :devices
      f.input :metadata
    end
    f.actions
  end
end
