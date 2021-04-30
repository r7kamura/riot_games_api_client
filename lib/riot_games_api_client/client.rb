# frozen_string_literal: true
require 'faraday'
require 'faraday_middleware'

module RiotGamesApiClient
  class Client
    # @param [String] api_key
    # @param [String] region
    def initialize(api_key:, region:)
      @api_key = api_key
      @region = region
    end

    # @param [String] summoner_id
    # @return [Faraday::Response]
    def get_champion_masteries(summoner_id:)
      get("/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}")
    end

    # @param [String] summoner_name
    # @return [Faraday::Response]
    def get_summoner(summoner_name:)
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
          content_type: /\bjson\b/
        )
      end
    end

    # @param [String] path
    def get(path)
      faraday_connection.get(path)
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
