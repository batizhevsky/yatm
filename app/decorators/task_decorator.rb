class TaskDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :creator
  decorates_association :responsible

  def assigned_name
    user.show_name if user
  end

  def creator_name
    creator.show_name if creator
  end

  def responsible_name
    responsible.show_name if responsible
  end
end
