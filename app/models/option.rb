class Option < ApplicationRecord
  belongs_to :question
  
  validates :value, uniqueness: { scope: :question_id }
end
