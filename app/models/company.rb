class Company < ApplicationRecord
  has_many :promotions
  has_many :articles, through: :promotions
end
