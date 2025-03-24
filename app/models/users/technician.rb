module Users
  class Technician < User
    has_many :fixing_cars, foreign_key: :technician_id
  end
end
