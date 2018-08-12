class Book < ApplicationRecord
  validates :title, :publisher, presence: true

  belongs_to :publisher
  has_many :stocks
  has_many :shops, through: :stocks
end
