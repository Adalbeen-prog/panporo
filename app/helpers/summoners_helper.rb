module SummonersHelper
  def get_name_from_id(json, id)
    json.find {|h1| h1[1]['key'] == id.to_s }[1]
  end

  def define_owner_of_game(name, match_details)
    owner_id = match_details['participantIdentities'].find{ |x| x['player']['summonerName'] == name }['participantId']
    match_details['participants'][owner_id.to_i - 1]
  end

  def get_image_from_summoner_spell_id(json, id)
    spell_name = get_name_from_id(json, id)['image']['full']
    return image_tag("/10.6.1/img/spell/#{spell_name}", class: 'summonerIcons')
  end

  def get_items(player)
    player['stats'].select { |key, value| key.to_s.match(/^item[0-5]+/) }
  end
  
  def team_different(teams)
    team1 = teams.select{ |x| x['teamId'] == 100 }
    team2 = teams.select{ |x| x['teamId'] == 200 }
    return team1, team2
  end

  def find_identity(id)
  end
end
