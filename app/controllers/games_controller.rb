class GamesController < ApplicationController
  
  def index
    @games = Game.all
  end

  def show
    @champions = Game.find(params[:id]).champions
  end

end