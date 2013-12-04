class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    #Trip Abilities
    can :read, Trip
    can [:create, :update, :destroy,], Trip, :user_id => user.id
    can [:message, :book], Trip do |trip|
      user.id != trip.user_id
    end

    #Profile Abilities
    can [:read], Profile
    can [:update], Profile do |profile|
      user.profile && user.profile.id == profile.id
    end

    #Booking Abilities
    can [:create, :read], Booking
    can :destroy, Booking, :user_id => user.id


    #Comment Abilities
    can :create, Comment

    #Conversation Abilities
    can [:update, :read], Conversation

  end
end
