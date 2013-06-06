class UserDecorator < Draper::Decorator
  delegate_all

  def show_name
    name || email
  end
end
