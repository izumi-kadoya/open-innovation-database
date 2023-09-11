class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # ゲストユーザーの場合

    if user.admin?
      can :manage, :all # 管理者はすべての操作が可能
    else
      if user.approved?
        can :read, :all # 承認された一般ユーザーは全て閲覧可能
        can :index, User # 削除予定
        can [:edit, :update], :all # 一般ユーザーは編集・更新可能
        cannot [:new, :create], :all # 一般ユーザーは新規作成不可
        cannot [:new, :create, :edit, :update, :destroy], User
      else
        can :read, Record # ゲストユーザーはトップページのみ閲覧可能
      end
    end
  end
end