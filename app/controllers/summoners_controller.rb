class SummonersController < ApplicationController

  def show
    @api = 'RGAPI-1cc40e95-0e20-4c2e-b7f0-25e20c483253'
    @region = 'eun1'
    @summonerinfo, @profile = get_profile('eun1', params[:summoner])
    @matches = get_match_history('eun1', @summonerinfo['accountId'])
    @queue = get_queue_types_json
    @champion_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/champion.json'))['data']
    @summoner_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/summoner.json'))['data']
  end

end
