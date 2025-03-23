# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  ban_reason                    :string
#  banned_at                     :datetime
#  devices                       :jsonb            not null
#  dob                           :datetime
#  email                         :string
#  email_otp                     :string
#  email_otp_sent_at             :datetime
#  email_verified_at             :datetime
#  first_name                    :string           default(""), not null
#  gender                        :string
#  impersonation_password_digest :string
#  last_name                     :string           default(""), not null
#  locale                        :string
#  metadata                      :jsonb            not null
#  password_digest               :string
#  phone                         :string
#  phone_otp                     :string
#  phone_otp_sent_at             :datetime
#  phone_verified_at             :datetime
#  reset_password_otp            :string
#  reset_password_otp_sent_at    :datetime
#  role                          :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  banned_by_id                  :bigint
#
# Indexes
#
#  index_users_on_banned_by_id        (banned_by_id)
#  index_users_on_devices             (devices) USING gin
#  index_users_on_email               (email)
#  index_users_on_email_otp           (email_otp) UNIQUE
#  index_users_on_metadata            (metadata) USING gin
#  index_users_on_phone               (phone)
#  index_users_on_phone_otp           (phone_otp) UNIQUE
#  index_users_on_reset_password_otp  (reset_password_otp) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (banned_by_id => admin_users.id)
#
class User < ApplicationRecord
  include WithPhone
  phonable :phone, presence: false, uniqueness: true, allow_blank: true

  has_secure_password
  has_secure_password :impersonation_password, validations: false

  attr_accessor :token

  before_validation do
    self.email = email.downcase if will_save_change_to_email?
  end

  validates :first_name, :last_name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: App::Constants::EMAIL_REGEX
            }
  validates :password,
            presence: true,
            length: {
              minimum: 6
            },
            if: -> { password_digest.blank? }

  def display_name
    if first_name.present? && last_name.present?
      return "#{first_name} #{last_name}"
    end
    return first_name if first_name.present?
    # masked_email
    email
  end

  def populate_token
    # Use user id in production and email in development
    self.token =
      App::Jwt.encode({ user_id: Rails.env == "development" ? email : id })
    self
  end

  def add_device(uid, args = {})
    self["devices"][uid] = args
  end

  def add_device!(uid, args = {})
    add_device(uid, args)
    save!
  end

  def remove_device(uid)
    self["devices"].delete(uid)
  end

  def remove_device!(uid)
    remove_device(uid)
    save
  end

  def update_device(uid, args)
    self["devices"][uid] = (self["devices"][uid] || {}).merge(args)
  end

  def update_device!(uid, args)
    update_device(uid, args)
    save
  end

  def banned?
    banned_at.present?
  end

  def parsed_phone
    @parsed_phone ||= Phonelib.parse(phone)
  end

  def email_verified?
    email_verified_at?
  end

  def phone_verified?
    phone_verified_at?
  end

  def generate_phone_otp!
    otp = nil
    loop do
      otp = SecureRandom.random_number(999_999).to_s.rjust(6, "0")
      break unless User.find_by_phone_otp(otp)
    end

    update!(phone_otp: otp)
    otp
  end

  def generate_email_otp!
    otp = nil
    loop do
      otp = SecureRandom.random_number(999_999).to_s.rjust(6, "0")
      break unless User.find_by_email_otp(otp)
    end

    update!(email_otp: otp)
    otp
  end

  def generate_reset_password_otp!
    otp = nil
    loop do
      otp = SecureRandom.random_number(999_999).to_s.rjust(6, "0")
      break unless User.find_by_reset_password_otp(otp)
    end

    update!(reset_password_otp: otp)
    otp
  end

  def impersonate!
    pass = SecureRandom.hex(8)

    self.impersonation_password = pass
    save!

    pass
  end
end
