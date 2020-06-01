class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      redirect_to new_question_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
      flash.notice = 'Successfully edited question'
    else
      redirect_to edit_question_path(@question)
      flash.alert = @question.errors.full_messages.join('. ')
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  private

  def question_params
    params.require('question').permit('body', options: [])
  end
end
