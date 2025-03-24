class FixingCar < ApplicationRecord
  belongs_to :car
  belongs_to :technician, class_name: "Users::Technician"

  has_one :problem, dependent: :destroy
  has_many :part_usages, dependent: :destroy

  accepts_nested_attributes_for :problem

  include AASM

  aasm column: :state, timestamp: true do
    state :pending, initial: true
    state :in_progress
    state :completed
    state :failed

    event :start do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end
  end
end
