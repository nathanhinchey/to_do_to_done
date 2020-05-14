class OptionsController < ApplicationController
  before_action :set_question

  def new
    @option = @question.options.build
  end

  def create
    @option = @question.options.build(option_params)
    if @option.save
      flash[:success] = 'Added option'
      redirect_to @question
    else
      flash[:error] = @option.errors.full_messages.join('. ')
      redirect_back(fallback_location: new_question_option_path(@question))
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update(option_params)
      flash[:success] = 'Updated option'
      redirect_to @question
    else
      flash[:error] = @option.errors.full_messages.join('. ')
      redirect_back(fallback_location: new_question_option_path(@question))
    end
  end

  def destroy
    @option = Option.find(params[:id])
    if @option.destroy
      flash[:success] = "Option '#{@option.value}' deleted"
    else
      flash[:error] = @option.errors.full_messages.join('. ')
    end
    redirect_to @question
  end

  private

  def option_params
    params.require(:option).permit(:rank, :value)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
