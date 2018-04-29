class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, email: true
  validates :body, presence: true, length: { in: 6..500 }
end
