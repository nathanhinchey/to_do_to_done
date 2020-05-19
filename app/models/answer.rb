class Answer < ApplicationRecord
  belongs_to :option
  belongs_to :survey

  validates :option, uniqueness: { scope: :survey }
end
