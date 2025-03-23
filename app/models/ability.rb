# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new
    # can :manage, ActiveAdmin::Page, name: 'Sign In'
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    can :manage, :all

    # if user.admin?
    #   case user.role
    #   when 'admin'
    #     can :manage, :all
    #   when 'store_viewer'
    #     can :read, Store
    #     can :read, Product
    #     can :read, Variant
    #     can %i[read batch_action batch_edit], User
    #   when 'viewer'
    #     can :read, :all
    #   end
    # end
  end
end
