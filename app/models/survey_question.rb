class SurveyQuestion < ApplicationRecord
  belongs_to :survey
  belongs_to :question

  validates :question, uniqueness: { scope: :survey }
end
