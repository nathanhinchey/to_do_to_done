require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "should not save question without body" do
    question = Question.new
    assert_not question.save
  end
end
