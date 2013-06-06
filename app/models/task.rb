class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: "User"
  belongs_to :creator, class_name: "User"

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :responsible
  accepts_nested_attributes_for :creator

  validates :title, presence: true
end
