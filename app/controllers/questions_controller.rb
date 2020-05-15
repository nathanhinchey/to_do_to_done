class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user_access, only: [:show, :edit]
  
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))
    if @question.save
      flash.notice = 'Question created'
    else
      flash.alert = @question.errors.full_messages.join('. ')
    end
    redirect_to @question
  end

  def show
    @question = Question.find(params[:id])
    @options = @question.options.order(:rank)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def index
    @questions = current_user.questions
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash.notice = 'Question updated'
    else
      flash.alert = @question.errors.full_messages.join('. ')
    end
    redirect_to @question
  end

  private
  
  def question_params
    params.require(:question).permit(:text)
  end

  def verify_user_access
    @question = Question.find(params[:id])
    if @question.user == current_user
      true
    else
      flash.alert = "That's not yours!"
      redirect_to root_path
    end
  end
end
