class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      false
    elsif user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
