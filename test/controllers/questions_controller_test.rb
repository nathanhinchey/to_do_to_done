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

  test "should create question with answer options" do
    # arrange
    body = 'What is your favorite color?'
    options = ['black', 'white']
    params = { question: { body: body, options: options } }
    # act
    post questions_path, params: params
    # assert
    created_question = Question.where(body: body)
    assert_equal 1, created_question.count
    assert_equal options, created_question.first.options
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

  test 'should show question options' do
    # arrange
    question_body = 'Is this a question?'
    question_options = ['No it is a dog', 'nope, a cat']
    question = Question.create(body: question_body, options: question_options)
    # act
    get question_path(question)
    # assert
    assert_includes response.body, question_options[0]
    assert_includes response.body, question_options[1]
  end

  # #index
  test 'should show all questions' do
    # arrange
    question_1 = Question.create(body: 'first question here')
    question_2 = Question.create(body: 'seconcd question lololol')
    # act
    get questions_path
    # assert
    assert_includes response.body, question_1.body
    assert_includes response.body, question_2.body
  end

  test 'should include link to edit question' do
    # arrange
    question = Question.create(body: 'This is a question lmao rofl bbq')
    # act
    get questions_path
    # assert
    assert_includes response.body, edit_question_path(question)
  end

  # #edit
  test 'should render an edit page' do
    # arrange
    question = Question.create(body: 'This is a question i think but idk')
    # act
    get edit_question_path(question)
    # assert
    assert_response :success
  end

  test 'should include current question body' do
    # arrange
    question = Question.create(body: 'this is a question body or whatever bro')
    # act
    get edit_question_path(question)
    # assert
    assert_includes response.body, question.body
  end

  # #update
  test 'should update question with params' do
    # arrange
    edited_body = 'After edits omg'
    question = Question.create(body: 'Before any edits')
    params = { question: { body: edited_body } }
    # act
    patch question_path(question), params: params
    # assert
    assert_equal edited_body, question.reload.body
  end

  test 'should redirect to edited question' do
    # arrange
    edited_body = 'After edits omg'
    question = Question.create(body: 'Before any edits')
    params = { question: { body: edited_body } }
    # act
    patch question_path(question), params: params
    # assert
    assert_redirected_to question
  end

  test 'should show success message' do
    # arrange
    edited_body = 'After edits omg'
    question = Question.create(body: 'Before any edits')
    params = { question: { body: edited_body } }
    # act
    patch question_path(question), params: params
    follow_redirect!
    # assert
    assert_select '.alert-notice', 'Successfully edited question'
  end

  test 'should redirect to edit if udpate fails' do
    # arrange
    question = Question.create(body: 'Before any edits')
    params = { question: { body: '' } } # empty string is inavlid
    # act
    patch question_path(question), params: params
    # assert
    assert_redirected_to edit_question_path(question)
  end

  test 'should show errors if udpate fails' do
    # arrange
    question = Question.create(body: 'Before any edits')
    params = { question: { body: '' } } # empty string is inavlid
    # act
    patch question_path(question), params: params
    follow_redirect!
    # assert
    assert_select '.alert-alert', "Body can't be blank"
  end
end
