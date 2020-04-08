class ChampionsController < ApplicationController
  def show
    @champion = Champion.find(params[:id])
  end
end