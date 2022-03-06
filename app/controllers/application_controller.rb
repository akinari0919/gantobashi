class ApplicationController < ActionController::Base
  before_action :require_login

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def render_404
    render template: 'errors/404', status: :not_found, layout: 'application', content_type: 'text/html'
  end

  def render_500
    render template: 'errors/500', status: :internal_server_error, layout: 'application', content_type: 'text/html'
  end

  private

  def not_authenticated
    redirect_to login_path
  end
end
