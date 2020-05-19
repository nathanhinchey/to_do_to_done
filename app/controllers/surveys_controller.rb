class SurveysController < ApplicationController
  before_action :authenticate_user!

  def new
    @survey = Survey.new(date: Date.today)
  end

  def create
    @survey = Survey.new(survey_params.merge(user: current_user))
    if @survey.save
      flash.notice = 'Survey created'
      redirect_to @survey
    else
      flash.alert = @survey.errors.full_messages
      redirect_back(fallback_location: new_survey_path)
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def index
    @surveys = current_user.surveys
  end

  # page for taking the survey
  def take
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(:date, :title)
  end
end
