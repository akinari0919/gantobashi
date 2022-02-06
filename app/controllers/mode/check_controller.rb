class Mode::CheckController < ApplicationController
  before_action :no_photo, {only: :show}

  def new; end

  def show
    @body = params[:body]
    @star = params[:star]
    @photo = params[:photo]
    @point1 = params[:point1]
    @point2 = params[:point2]
    @rank = params[:rank]
  end

  private

  def no_photo
    if params[:body] == nil
      redirect_to mode_select_path
    end
  end
end