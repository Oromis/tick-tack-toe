json.array! @games do |game|
  json.id game.id
  json.status game.status
  json.playerX do
    if game.player_x.nil?
      json.null!
    else
      json.id game.player_x.id
      json.name game.player_x.name
    end
  end
  json.playerO do
    if game.player_o.nil?
      json.null!
    else
      json.id game.player_o.id
      json.name game.player_o.name
    end
  end
end
