class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    Player.create(player_params)
    flash[:notice] = 'Player successfully created!'
    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :job, :health, :magic)
  end
end
