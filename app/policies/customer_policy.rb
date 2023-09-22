class CustomerPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  def index?
    @user.editor? || @user.admin?
  end

  alias show? index?
  alias new? index?
  alias edit? index?
  alias create? index?
  alias update? index?
  alias destroy? index?
end
