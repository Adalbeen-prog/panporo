class SummonersController < ApplicationController

  def show
    @api = ENV['RIOT_API'] ? ENV['RIOT_API'] : 'RGAPI-9b91504a-d78d-45f3-96ee-0c7be2d0858c'
    @region = 'eun1'
    @version = '10.7.1'
    @summonerinfo, @profile = get_profile('eun1', params[:summoner])
    @matches = get_match_history('eun1', @summonerinfo['accountId'])
    @pagy_matches, @matches = pagy_array(@matches['matches'], items: 5)
    @queue = get_queue_types_json
    @champion_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/champion.json")['data']
    @summoner_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/summoner.json")['data']
  end

  def match
    @api = ENV['RIOT_API'] ? ENV['RIOT_API'] : 'RGAPI-9b91504a-d78d-45f3-96ee-0c7be2d0858c'
    @region = 'eun1'
    @version = '10.7.1'
    @champion_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/champion.json")['data']
    @summoner_json = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/summoner.json")['data']
    @runes = parse_http_json("http://ddragon.leagueoflegends.com/cdn/#{@version}/data/cs_CZ/runesReforged.json")
  end
end
