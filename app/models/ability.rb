class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    #Trip Abilities
    can :read, Trip
    can [:create, :update, :destroy], Trip, :user_id => user.id

    #Profile Abilities
    can [:read], Profile
    can [:update], Profile do |profile|
      user.profile && user.profile.id == profile.id
    end

    #Booking Abilities
    can :create, Booking
    can :destroy, Booking, :user_id => user.id

    #Comment Abilities
    can :create, Comment

    #Conversation Abilities
    can [:create, :update, :destroy, :read], Conversation

  end
end
