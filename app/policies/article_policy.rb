class ArticlePolicy < ApplicationPolicy
  def permitted_attributes
    %i[title text tags image]
  end

  def update?
    record.author == user
  end

  def destroy?
    record.author == user
  end
end
