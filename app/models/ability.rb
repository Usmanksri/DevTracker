class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new 
    if user.role == "manager"
      can :manage, :all
    elsif user.role == "member"
      can :read, Project
      can [:read, :update], Task
      can [:read, :update], Comment, user_id: user.id
    end
  end
end
