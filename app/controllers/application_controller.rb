class ApplicationController < ActionController::API
  include AbstractController::Rendering
  include ActionView::Layouts

  append_view_path "#{Rails.root}/app/views"

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
