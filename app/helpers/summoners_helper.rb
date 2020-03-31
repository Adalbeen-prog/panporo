module SummonersHelper
  def get_name_from_id(json, id)
    json.find {|h1| h1[1]['key'] == id.to_s }[1]
  end


  def define_owner_of_game(name, match_details)
    owner_id = match_details['participantIdentities'].find{ |x| x['player']['summonerName'] == name }['participantId']
    match_details['participants'][owner_id.to_i - 1]
  end
end
