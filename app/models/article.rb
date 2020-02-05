class Article < ApplicationRecord
  belongs_to :user

  # All attributes need to be filled in order to be committed to the DB
  # other criteria may have to be met
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true
end