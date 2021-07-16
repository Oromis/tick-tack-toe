class Api::GamesController < Api::JsonApiController
  def index
    if current_user.nil?
      render_json({}, status: 401)
    end

    @games = Game.all
  end
end
