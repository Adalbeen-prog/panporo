class SummonersController < ApplicationController

  def show
    @api = ENV['RIOT_API'] ? ENV['RIOT_API'] : 'RGAPI-466ae6b3-1134-4f95-ac6e-7f904c858e75'
    @region = 'eun1'
    @summonerinfo, @profile = get_profile('eun1', params[:summoner])
    @matches = get_match_history('eun1', @summonerinfo['accountId'])
    @pagy_matches, @matches = pagy_array(@matches['matches'], items: 5)
    @queue = get_queue_types_json
    @champion_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/champion.json'))['data']
    @summoner_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/summoner.json'))['data']
  end

  def match
    @champion_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/champion.json'))['data']
    @summoner_json = JSON.parse(File.read('public/10.6.1/data/cs_CZ/summoner.json'))['data']
    @api = ENV['RIOT_API'] ? ENV['RIOT_API'] : 'RGAPI-466ae6b3-1134-4f95-ac6e-7f904c858e75'
    @region = 'eun1'
  end
end
