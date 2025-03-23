class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      # user info
      t.string :email
      t.string :phone

      # password
      t.string :password_digest
      t.string :impersonation_password_digest
      t.string :reset_password_otp
      t.datetime :reset_password_otp_sent_at

      # email verification
      t.string :email_otp
      t.datetime :email_otp_sent_at
      t.datetime :email_verified_at

      # phone verification
      t.string :phone_otp
      t.datetime :phone_otp_sent_at
      t.datetime :phone_verified_at

      # user info
      t.datetime :banned_at
      t.string :ban_reason
      t.references :banned_by,
                   foreign_key: {
                     to_table: :admin_users
                   },
                   index: true

      # user info
      t.string :locale

      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :gender
      t.datetime :dob

      t.jsonb :devices, null: false, default: {}
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end

    # # # indexes
    add_index :users, :email
    add_index :users, :email_otp, unique: true

    add_index :users, :phone
    add_index :users, :phone_otp, unique: true

    add_index :users, :reset_password_otp, unique: true

    add_index :users, :devices, using: :gin
    add_index :users, :metadata, using: :gin
  end
end
