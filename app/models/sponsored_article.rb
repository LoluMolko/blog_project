class SponsoredArticle < Article
  has_one :promotion, foreign_key: :article_id
  has_one :company, through: :promotion
end