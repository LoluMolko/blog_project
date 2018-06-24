class Promotion < ApplicationRecord
  belongs_to :sponsored_article, foreign_key: :article_id
  belongs_to :company
end
