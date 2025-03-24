# == Schema Information
#
# Table name: cars
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  plate_number :string           not null
#  color        :string           not null
#  brand        :string           not null
#  model        :string           not null
#  year         :integer          not null
#  member_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_cars_on_member_id  (member_id)
#

require "test_helper"

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
