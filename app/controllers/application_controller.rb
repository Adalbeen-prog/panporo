class ApplicationController < ActionController::Base
  helper_method :get_match_info

  def parse_http_json(url)
    api_uri = URI.parse(URI.escape(url))
    api_response = Net::HTTP.get(api_uri)
    JSON.parse(api_response)
  end

  def get_profile(region, summoner) 
    summoner_info = parse_http_json("https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner}?api_key=#{@api}")
    profile = parse_http_json("https://#{region}.api.riotgames.com/lol/league/v4/entries/by-summoner/#{summoner_info['id']}?api_key=#{@api}")[0]
    return summoner_info, profile
  end

  def get_match_history(region, account)
    parse_http_json("https://#{region}.api.riotgames.com/lol/match/v4/matchlists/by-account/#{account}?api_key=#{@api}")
  end

  def get_queue_types_json
    parse_http_json('http://static.developer.riotgames.com/docs/lol/queues.json')
  end

  def get_match_info(region, match_id)
    parse_http_json("https://#{region}.api.riotgames.com/lol/match/v4/matches/#{match_id}?api_key=#{@api}")
  end


end
