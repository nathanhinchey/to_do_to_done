class SurveyQuestionsController < ApplicationController
  before_action :set_survey

  def new
    @survey_question = SurveyQuestion.new(survey: @survey)
  end

  def create
    @survey_question = SurveyQuestion.new(survey_question_params.merge(survey: @survey))
    if @survey_question.save
      flash.notice = 'Added question to survey'
      redirect_to @survey
    else
      flash.alert = @survey_question.errors.full_messages.join('. ')
      redirect_back(fallback_location: new_survey_survey_question_path)
    end
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:question_id)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end
end
