class PagesController < ApplicationController
  def home
    current_date = params[:week] ? Date.parse(params[:week]) : Date.today
    @first_day_of_week = current_date.beginning_of_week(:monday)
    @last_day_of_week = current_date.end_of_week(:saturday)
    @dates_for_days = (0..4).map { |day| @first_day_of_week + day }
  end
end
