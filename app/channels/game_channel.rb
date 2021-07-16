class GameChannel < ApplicationCable::Channel
  def subscribed
    game_id = params[:id]
    logger.info "New subscription for game #{game_id}"
    game = Game.find_by id: game_id
    transmit game
  end
end
