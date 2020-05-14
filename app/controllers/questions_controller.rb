class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    redirect_to @question
  end

  def show
    @question = Question.find(params[:id])
    @options = @question.options.order(:rank)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = 'Question updated'
    else
      flash[:error] = @question.errors.full_messages.join('. ')
    end
    redirect_to @question
  end

  private
  
  def question_params
    params.require(:question).permit(:text)
  end
end
