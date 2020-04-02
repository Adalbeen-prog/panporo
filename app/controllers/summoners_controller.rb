class SummonersController < ApplicationController
  before_action :set_dependencies, only: [:show, :match, :live]

  def show
    @matches_json = get_match_history('eun1', @summonerinfo['accountId'])
    @pagy_matches, @matches = pagy_array(@matches_json['matches'], items: 5)
  end

  def match
  end

  def live
  end

  private

  def set_dependencies
    @api = ENV['RIOT_API'] ? ENV['RIOT_API'] : 'RGAPI-94ae091e-8fd2-4d34-aa78-76a313c0031f'
    @region = 'eun1'
    @version = '10.7.1'
    @queue = get_queue_types_json
    @champion_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/champion.json")['data']
    @summoner_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/summoner.json")['data']
    @summonerinfo, @profile = get_profile(@region, params[:summoner])
    @runes = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/runesReforged.json")
  end
end
