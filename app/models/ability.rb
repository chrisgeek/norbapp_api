# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    alias_action :create, :read, :update,    to: :cru
    alias_action :create, :update, :destroy, to: :cud
    alias_action :read, :update,             to: :ru

    user ||= User.new
    user_group = user.groups.users

    if user.present?
      can :read, User, group: user_group
      can :ru, user
      can :user, User # access current user
    end

    case user.role
    when 'super_admin'
      can :manage, :all
    when 'admin'
      can :manage, User, group: user_group
      can :confirm, User, group: user_group
      can :manage, Group, id: user_group.id
    when 'member'
      can :read, User, group: user_group
      can :manage, User, id: user.id
    end
    cannot :destroy, user # cannot destroy self
  end
end
