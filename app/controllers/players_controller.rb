class PlayersController < ActionController::Base

  def index
    @players = Player.order(:name)
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save!
      redirect_to root_path, notice: 'Player was successfully created.'
    else
      flash.now[:alert] = @player.errors.full_messages.join(', ')
      render :new
    end
  end

  # def add
  #  all_players = []
  #   number.times do
  #   player = []
  #   player << Player[:name]#.sample
  # end
 private

  def player_params
    params.require(:player).permit(:name, :job, :health, :magic)
  end

end
