class HomeController < ApplicationController
  skip_before_action :require_login

  def top; end
  def about; end
  def info; end
  def service; end
  def privacy; end
  def check; end
  def create; end
end
