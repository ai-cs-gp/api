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

class Solution < ApplicationRecord
  belongs_to :problem
  has_many :part_usages, dependent: :destroy
end
