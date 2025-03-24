# == Schema Information
#
# Table name: solutions
#
#  id          :integer          not null, primary key
#  description :string           not null
#  problem_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_solutions_on_problem_id  (problem_id)
#

require "test_helper"

class SolutionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
