module Users
  class Member < User
    has_many :cars, dependent: :destroy
  end
end
