# == Schema Information
#
# Table name: problems
#
#  id            :integer          not null, primary key
#  description   :string           not null
#  fixing_car_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_problems_on_fixing_car_id  (fixing_car_id)
#

require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
