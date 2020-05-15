class Survey < ApplicationRecord
  belongs_to :user
  has_many :survey_questions
  has_many :questions, through: :survey_questions

  validates :user, presence: true
end
