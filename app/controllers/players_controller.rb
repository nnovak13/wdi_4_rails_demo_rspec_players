class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:notice] = 'Player successfully created!'
      redirect_to root_path
    else
      flash.now[:alert] = @player.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :job, :health, :magic)
  end
end
