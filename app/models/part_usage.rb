# == Schema Information
#
# Table name: part_usages
#
#  id          :integer          not null, primary key
#  quantity    :integer          not null
#  price       :decimal(10, 2)   not null
#  part_id     :integer          not null
#  solution_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_part_usages_on_part_id      (part_id)
#  index_part_usages_on_solution_id  (solution_id)
#

class PartUsage < ApplicationRecord
  belongs_to :part
  belongs_to :solution
end
