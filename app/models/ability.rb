# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    alias_action :create, :read, :update,    to: :cru
    alias_action :create, :update, :destroy, to: :cud
    alias_action :read, :update,             to: :ru

    user ||= User.new
    user_group = user.groups.each(&:users)

    if user.present?
      can :read, User, group: user_group
      can :create, Group
      can :ru, user
    end

    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :admin
      can :manage, User, group: user_group
      can :confirm, User, group: user_group
      can :manage, Group, id: user_group.id
    else
      can :read, User, group: user_group
      can :read, Group, id: user_group.id
      can :manage, User, id: user.id
    end
    cannot :destroy, user # cannot destroy self
  end
end
