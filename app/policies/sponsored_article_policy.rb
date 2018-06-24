class SponsoredArticlePolicy < ArticlePolicy
  def permitted_attributes
    %i[title text tags image company]
  end
end
