class Api::SessionsController < Api::JsonApiController
  def create
    user = User.find_by(name: params[:name])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id.to_s
      render_json({})
    else
      logger.warn "Incorrect login attempt for user #{params[:name]}"
      render_json({ errors: user&.errors&.full_messages }, status: 400)
    end
  end
end
