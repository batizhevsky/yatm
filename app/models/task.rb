class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: "User"
end
