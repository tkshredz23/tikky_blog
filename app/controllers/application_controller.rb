class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user_authorized?

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def after_sign_in_path_for(resource)
    user_posts_path(current_user)
  end

  def authorize_user
    unless current_user_authorized?
      redirect_to new_user_session_path
    end
  end

  def current_user_authorized?
    params[:user_id].present? && current_user && current_user.id == params[:user_id].to_i
  end
end
