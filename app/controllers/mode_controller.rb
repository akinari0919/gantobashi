class ModeController < ApplicationController
  before_action :no_photo, {only: :check_show}

  def index; end

  def check; end

  def check_show
    @body = params[:body]
    @star = params[:star]
    @photo = params[:photo]
    @point1 = params[:point1]
    @point2 = params[:point2]
    @rank = params[:rank]
  end

  def training; end

  private

  def no_photo
    if params[:body] == nil
      redirect_to mode_index_path
    end
  end
end
