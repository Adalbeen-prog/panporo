# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'uri'
require 'json'

api_uri = URI.parse(URI.escape("http://ddragon.leagueoflegends.com/cdn/10.7.1/data/cs_CZ/championFull.json"))
response = Net::HTTP.get(api_uri)
json = JSON.parse(response)


Champion.delete_all
Game.delete_all

lol = Game.create(name: "League of Legends", image: "lol.jpg")
json['data'].each do |champion|
  Champion.create name: champion[1]['name'],
                  title: champion[1]['title'],
                  image: champion[1]['image']['full'],
                  sprite: champion[1]['image']['sprite'],
                  skins: champion[1]['skins'],
                  lore: champion[1]['lore'],
                  tags: champion[1]['tags'],
                  info: champion[1]['info'].to_a,
                  stats: champion[1]['stats'].to_a,
                  spells: champion[1]['spells'],
                  recommended: champion[1]['recommended'],
                  game_id: lol.id
end