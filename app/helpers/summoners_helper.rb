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
    return image_tag("http://ddragon.leagueoflegends.com/cdn/#{@version}/img/spell/#{spell_name}", class: 'summonerIcons')
  end

  def get_items(player)
    player['stats'].select { |key, value| key.to_s.match(/^item[0-5]+/) }
  end
  
  def team_different(teams)
    team1 = teams.select{ |x| x['teamId'] == 100 }
    team2 = teams.select{ |x| x['teamId'] == 200 }
    return team1, team2
  end

  def find_main_runes_by_id(id)
    @runes.find { |x| x['id'] == id }
  end

  def largest_hash_key(hash1, hash2, thing)
    a = hash1.max_by{|k| k['stats'][thing] }['stats'][thing]
    b = hash2.max_by{|k| k['stats'][thing] }['stats'][thing]

    return [a, b].sort[1]
  end

  def all_team_hash(hash, thing)
    hash.map{|k| k['stats'][thing] }.inject(:+)
  end

  def count_stats(team1, team2)
    max_in_team = {'0' => {}, '1' => {}}
    all_team = {'0' => {}, '1' => {}}
    [team1, team2].each_with_index do |team, i|
      ['kills','goldEarned','totalDamageDealtToChampions', 'wardsPlaced', 'totalDamageTaken','totalMinionsTotal'].each do |stat|
        max_in_team[i.to_s].merge!({stat => largest_hash_key(team1, team2, stat)})
        all_team[i.to_s].merge!({stat => all_team_hash(team, stat)})
      end
    end
    return max_in_team, all_team
  end

  def add_minions_and_monsters(team1, team2)
    [team1, team2].each do |team|
      team.each do |player|
        player['stats'].merge!({'totalMinionsTotal' => player['stats']['totalMinionsKilled'] + player['stats']['neutralMinionsKilled']})
      end
    end
  end

  def make_percentage_from_max(value, max)
    return ((value.to_f / max.to_f)*100).floor
  end
  
  def team_ratio(all_team, stat)
    counted = all_team['0'][stat] + all_team['1'][stat]
    team1 = (all_team['0'][stat].to_f / counted.to_f * 100).round(2)
    team2 = (all_team['1'][stat].to_f / counted.to_f * 100).round(2)
    return [team1, team2]
  end


  def ranked_stats(summoner_details)
    stats = {}
    puts summoner_details
    summoner_details.each do |league|
      puts league
      stats.merge!({league['queueType'] => league})
    end
    stats
  end

  def winratio(win, loss)
    counted = win + loss
    percentage = (win.to_f / counted.to_f * 100 ).floor
    return counted, percentage
  end

end
