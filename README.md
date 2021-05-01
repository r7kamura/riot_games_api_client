# RiotGamesApiClient

Riot Games API client for Ruby.

See https://developer.riotgames.com/ for more details about Riot Games API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'riot_games_api_client'
```

And then execute:

```
bundle install
```

Or install it yourself as:

```
gem install riot_games_api_client
```

## Usage

```ruby
require 'riot_games_api_client'

client = RiotGamesApiClient::Client.new(
  api_key: 'RGAPI-12345678-90ab-cdef-1234-567890abcdef',
  region: 'jp1',
)

response = client.get_summoner(summoner_name: 'summoner_name')
summoner_id = response.body['id']

response = client.get_champion_masteries(summoner_id: summoner_id)
```

### Supported endpoints

- `RiotGamesApiClient::Client#get_champion_masteries(summoner_id:)`
- `RiotGamesApiClient::Client#get_summoner(summoner_name:)`
