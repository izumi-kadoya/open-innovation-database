class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # ゲストユーザーの場合

    if user.admin?
      can :manage, :all # 管理者はすべての操作が可能
    elsif user.approved?
      can :read, :all # 一般ユーザーは全て閲覧可能
      can :download, Record # 一般ユーザーはダウンロード可能
      can [:edit, :update], :all # 一般ユーザーは編集・更新可能
      cannot [:new, :create], :all # 一般ユーザーは新規作成不可
      cannot [:new, :create, :edit, :update, :destroy], User
    else
      can :index, Record # ゲストユーザーはトップページのみ閲覧可能
    end
  end
end
