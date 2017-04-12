class GameSerializer

  def initialize(game)
    @game = game
  end

  def as_json(*)
    data = {
      id: @game.id,
      name: @game.name,
      genre: @game.genre,
    }
    data[:errors] = @game.errors if @game.errors.any?
    data
  end
end
