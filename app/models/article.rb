class Article < ApplicationRecord
  include Flaggable
  
  scope :tags_any, ->(args) { where('? = any(tags)', args) }

  def self.ransackable_scopes(auth_object = nil)
    [:tags_any]
  end

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { minimum: 5 }
  validate :title_changes
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes

  belongs_to :author, class_name: 'User'

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  # tags = dlatego, ze ta metoda jest getterem.
  # Automatycznie uzywamy sanitize_tags out of the box
  # za kazdym razem kiedy bedziemy nadpisywac ten element

  scope :most_commented, -> { order(comments_count: :desc).limit(1) }

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end

  def title_changes
    if title_changed? && self.persisted? && created_at < 7.days.ago # to jest magiczna metoda, underscore _changed wywowlane na czymkolwiek to automatycznie sprawdza zmiany (jest jeszcze _was? co pokazuje poprzednia wartosc)
      errors.add(:title, 'cannot be changed')
    end
  end
end
