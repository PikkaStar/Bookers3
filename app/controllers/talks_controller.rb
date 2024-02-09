class TalksController < ApplicationController
  before_action :authenticate_user!

  def create
    area = Area.find(params[:area_id])
    @talk = current_user.talks.new(talk_params)
    @talk.area_id = area.id
    if @talk.save
      redirect_to request.referer
    else
      @talks = @area.talks.page(params[:page]).per(10)
    　render controller: 'areas', action: 'show'
    　@talk = Talk.new
    end
  end

  def destroy
     talk = Talk.find(params[:id])
     talk.destroy
     redirect_to request.referer
  end

  private

  def talk_params
    params.require(:talk).permit(:message)
  end

end
