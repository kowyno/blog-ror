class ArticlePolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def publish?
    user_owns_article?
  end

  def unpublish?
    user_owns_article?
  end

  def create?
    user.present?
  end

  def show?
    true
  end

  def edit?
    user_owns_article?
  end

  def update?
    user_owns_article?
  end

  def destroy?
    user_owns_article?
  end

  def user_owns_article?
    user.present? && record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.present?
        scope.where(user_id: user.id).or(scope.where(publication_state: "published"))
      else
        scope.where(publication_state: "published")
      end
    end
  end
end
