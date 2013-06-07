class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: "User"
  belongs_to :creator, class_name: "User"

  validates :title, presence: true

  state_machine :state, initial: :opened do
    event :start do
      transition [:opened, :closed] => :started
    end

    event :close do
      transition [:opened, :started] => :closed
    end
  end

end
