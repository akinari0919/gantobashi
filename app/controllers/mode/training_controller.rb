class Mode::TrainingController < ApplicationController
  skip_before_action :require_login

  def new; end
end
