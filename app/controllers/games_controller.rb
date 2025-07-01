class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :edit, :update, :destroy ]

  def index
    @games = Game.all
  end

  def show
    @game = Game.includes(cards: :card_sessions).find(params[:id])
    @game_session = @game.game_sessions.find_by(session_id: session.id.to_s)
    @session_player_map = @game.game_sessions.map do |session|
      {
        session_id: session.id,
        player_id: session.player_id
      }
    end
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    Card.shapes.keys.each do |shape|
      Card.colors.keys.each do |color|
        Card.textures.keys.each do |texture|
          (1..3).each do |number|
            @game.cards.build(shape: shape, color: color, texture: texture, number: number)
          end
        end
      end
    end

    if @game.save
      redirect_to @game, notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: "Game was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: "Game was successfully destroyed."
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.expect(game: [ :name ])
  end
end
