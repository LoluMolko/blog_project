class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  has_many :comments, dependent: :destroy #komentarze znikna jesli usuniey artykul - dependent: :destroy
  belongs_to :author, class_name: "User"

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  #tags = dlatego, ze ta metoda jest getterem. Automatycznie uzywamy sanitize_tags out of the box, za kazdym razem kiedy bedziemy nadpisywac ten element

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
