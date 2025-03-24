# == Schema Information
#
# Table name: parts
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string           not null
#  brand       :string           not null
#  model       :string           not null
#  year        :integer          not null
#  member_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_parts_on_member_id  (member_id)
#

require "test_helper"

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
