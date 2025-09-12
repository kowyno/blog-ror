class Article < ApplicationRecord
  # Relaciones
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  # Validaciones
  validates :title, presence: true
  validates :user, presence: true

  # Estado
  enum :publication_state, draft: 0, published: 1
end