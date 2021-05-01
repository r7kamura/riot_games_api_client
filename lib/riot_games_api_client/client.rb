# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module RiotGamesApiClient
  class Client
    # @param [String] api_key
    # @param [String] region One of the following values:
    #   - americas
    #   - asia
    #   - br1
    #   - eun1
    #   - europe
    #   - euw1
    #   - jp1
    #   - kr
    #   - la1
    #   - la2
    #   - na1
    #   - oc1
    #   - ru
    #   - tr1
    def initialize(api_key:, region:)
      @api_key = api_key
      @region = region
    end

    # @param [String] summoner_id
    # @return [Faraday::Response]
    def get_lol_champion_masteries(summoner_id:)
      get("/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}")
    end

    # @param [String] champion_id
    # @param [String] summoner_id
    # @return [Faraday::Response]
    def get_lol_champion_mastery(champion_id:, summoner_id:)
      get("/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}/by-champion/#{champion_id}")
    end

    # @param [String] summoner_id
    # @return [Faraday::Response]
    def get_lol_champion_mastery_score(summoner_id:)
      get("/lol/champion-mastery/v4/scores/by-summoner/#{summoner_id}")
    end

    # @return [Faraday::Response]
    def get_lol_champion_rotations
      get('/lol/platform/v3/champion-rotations')
    end

    # @param [String] team_id
    # @return [Faraday::Response]
    def get_lol_clash_players(team_id:)
      get("lol/clash/v1/teams/#{team_id}")
    end

    # @param [String] team_id
    # @return [Faraday::Response]
    def get_lol_clash_team(team_id:)
      get("lol/clash/v1/teams/#{team_id}")
    end

    # @param [String] team_id
    # @param [String] tournament_id
    # @return [Faraday::Response]
    def get_lol_clash_tournament(team_id: nil, tournament_id: nil)
      if team_id
        get_lol_clash_tournament_by_team_id(team_id: team_id)
      elsif tournament_id
        get_lol_clash_tournament_by_tournament_id(tournament_id: tournament_id)
      else
        raise ::ArgumentError
      end
    end

    # @param [String] summoner_name
    # @return [Faraday::Response]
    def get_lol_summoner(summoner_name:)
      get("/lol/summoner/v4/summoners/by-name/#{summoner_name}")
    end

    private

    # @return [Faraday::Connection]
    def faraday_connection
      @faraday_connection ||= ::Faraday::Connection.new(
        headers: headers,
        url: url,
      ) do |connection|
        connection.response(
          :json,
          content_type: /\bjson\b/,
        )
      end
    end

    # @param [String] path
    # @return [Faraday::Response]
    def get(path)
      faraday_connection.get(path)
    end

    # @param [String] team_id
    # @return [Faraday::Response]
    def get_lol_clash_tournament_by_team_id(team_id:)
      get("/lol/clash/v1/tournaments/by-team/#{team_id}")
    end

    # @param [String] team_id
    # @return [Faraday::Response]
    def get_lol_clash_tournament_by_tournament_id(tournament_id:)
      get("/lol/clash/v1/tournaments/#{tournament_id}")
    end

    # @return [Hash]
    def headers
      { 'X-Riot-Token' => @api_key }
    end

    # @return [String]
    def url
      "https://#{@region}.api.riotgames.com"
    end
  end
end
