class Flag < ApplicationRecord
  belongs_to :flaggable, polymorphic: true
end
