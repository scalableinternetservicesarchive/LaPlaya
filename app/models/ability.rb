class Ability
  include CanCan::Ability

  RESTFUL_ACTIONS = [:show, :index, :create, :new, :update, :edit, :destroy]

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    can :read, Project
    can :read, Gallery
    can :read, Comment
    alias_action :read, :update, :destroy, to: :rud
    if user
      if user.super_admin?
        can :manage, :all
      end
      #Can create a new Project/Gallery/Comment
      can :create, Project
      can :create, Gallery
      can :create, Comment
      #Can 'rud', aka, read update destroy, their own projects/galleries/comments
      can :rud, Project, user_id: user.id
      can :rud, Gallery, user_id: user.id
      can :rud, Comment, user_id: user.id
      cannot :create, Comment, Comment.all do |comment|
        comment.parent && comment.parent.deleted?
      end

      can [:create, :destroy], ProjectLike, user_id: user.id
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
