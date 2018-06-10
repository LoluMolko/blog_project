class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { minimum: 5 }
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes
  # dpn destroy komentarze znikna jesli usuniety artykul

  belongs_to :author, class_name: 'User'

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  # tags = dlatego, ze ta metoda jest getterem.
  # Automatycznie uzywamy sanitize_tags out of the box
  # za kazdym razem kiedy bedziemy nadpisywac ten element

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end

  scope :most_commented, -> { order(comments_count: :desc).limit(1) }
end
