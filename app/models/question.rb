class Question < ApplicationRecord
  has_many :options
  belongs_to :user

  validates :user, presence: true
end
