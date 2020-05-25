require 'test_helper'
if Date.today > Date.parse('2020-06-01')
  raise 'check if Sprockets is updated yet'
else
  Warning[:deprecated] = false
end

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  # #new
  test "should have a new questions page" do
    get new_question_path
    assert_response :success
  end

  # #create
  test "should create a question" do
    params = { question: { body: 'Is this a question?' } }
    assert_difference('Question.count') do
      post questions_path, params: params
    end
  end

  test "should redirect to show newly created question" do
    # arrange
    question_body = 'Is this a question?'
    params = { question: { body: question_body } }
    # act
    post questions_path, params: params
    # assert
    assert_response :redirect
    follow_redirect!
    assert_includes response.body, question_body
  end

  test "should redirect back to new page for invalid question params" do
    # arrange
    params = { question: { body: '' } } # empty body is invalid
    # act
    post questions_path, params: params
    # assert
    assert_redirected_to new_question_path
  end

  # #show
  test 'should show a question' do
    # arrange
    question_body = 'Is this a question?'
    question = Question.create(body: question_body)
    # act
    get question_path(question)
    # assert
    assert_includes response.body, question_body
  end
end
