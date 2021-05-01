# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RiotGamesApiClient::Client do
  let(:client) do
    described_class.new(
      api_key: api_key,
      region: 'jp1',
    )
  end

  let(:api_key) do
    'dummy_api_key'
  end

  shared_examples 'returns a Faraday::Response' do
    it 'returns a Faraday::Response' do
      is_expected.to be_a(Faraday::Response)
      expect(stub).to have_been_requested
    end
  end

  describe '#get_champion_masteries' do
    subject do
      client.get_champion_masteries(summoner_id: summoner_id)
    end

    let!(:stub) do
      stub_request(
        :get,
        "https://jp1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}",
      ).with(
        headers: {
          'X-Riot-Token' => api_key
        },
      )
    end

    let(:summoner_id) do
      'dummy_summoner_id'
    end

    include_examples 'returns a Faraday::Response'
  end

  describe '#get_summoner' do
    subject do
      client.get_summoner(summoner_name: summoner_name)
    end

    let!(:stub) do
      stub_request(
        :get,
        "https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner_name}",
      ).with(
        headers: {
          'X-Riot-Token' => api_key
        },
      )
    end

    let(:summoner_name) do
      'dummy_summoner_name'
    end

    include_examples 'returns a Faraday::Response'
  end
end
