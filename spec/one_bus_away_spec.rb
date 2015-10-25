require 'one_bus_away'

RSpec.describe OneBusAway do
  let(:one_bus_away) { OneBusAway.new }

  describe '.new' do
    it 'responds' do
      expect(OneBusAway).to respond_to(:new)
    end

    it 'has an accessor for parameters' do
      one_bus_away.parameters = 'parameters'

      expect(one_bus_away.parameters).to eq('parameters')
    end

    it 'has an accessor for api_method' do
      one_bus_away.api_method = 'method'

      expect(one_bus_away.api_method).to eq('method')
    end

    it 'has a reader client' do
      expect(one_bus_away).to respond_to(:client)
    end

    it 'does not have a writer for client' do
      expect { one_bus_away.client = '' }.to raise_error(NoMethodError)
    end
  end

  describe '#assign_data' do
    let(:valid_client) { OneBusAway.new }

    it 'responds' do
      expect(one_bus_away).to respond_to(:assign_data)
    end

    it 'assigns @data', :vcr do
      one_bus_away.current_time

      expect(one_bus_away.data.entry.time).to eq(1_445_727_779_101)
    end
  end

  describe '#data' do
    it { is_expected.to respond_to(:data) }
  end

  describe '#call_api', :vcr do
    it { is_expected.to respond_to(:call_api) }

    it 'sets @data' do
      one_bus_away.current_time

      expect(one_bus_away.data).to be_kind_of(RecursiveOpenStruct)
    end
  end

  describe '#current_time', :vcr do
    let(:one_bus_away_client) { allow_any_instance_of(OneBusAway::Client) }

    it 'responds' do
      expect(one_bus_away).to respond_to(:current_time)
    end

    it 'creates @client' do
      one_bus_away.current_time

      expect(one_bus_away.client).to be_a(OneBusAway::Client)
    end

    it 'fails if .build_url doesnt validate' do
      one_bus_away_client.to receive(:valid?).and_return(false)
      allow_any_instance_of(OneBusAway)
        .to receive(:assign_data)
        .and_return(true)

      expect { one_bus_away.current_time }
        .to raise_error(RuntimeError, 'url is not properly built')
    end

    it 'sets http_response' do
      one_bus_away.current_time

      expect(one_bus_away.client.http_response.code).to eq(200)
    end
  end

  describe '#arrivals-and-departures-for-stop', :vcr do
    let(:one_bus_away_client) { allow_any_instance_of(OneBusAway::Client) }

    it 'responds with 1 arguments' do
      expect(one_bus_away)
        .to respond_to(:arrivals_and_departures_for_stop)
        .with(1).argument
    end

    it 'creates @client' do
      one_bus_away.arrivals_and_departures_for_stop(1_234_567)

      expect(one_bus_away.client).to be_a(OneBusAway::Client)
    end

    it 'sets http_response' do
      one_bus_away.arrivals_and_departures_for_stop(19_360)

      expect(one_bus_away.client.http_response.code).to eq(200)
    end
  end

  describe '#filter_by_route', :vcr do
    it { is_expected.to respond_to(:filter_by_route) }

    it 'outputs array' do
      one_bus_away.arrivals_and_departures_for_stop(19_360)

      expect(one_bus_away.filter_by_route).to be_kind_of(Array)
    end
  end

  describe '#get_location', :vcr do
    it { expect(OneBusAway.new).to respond_to(:get_location) }
    it 'returns the latitude and longitude of a given address in Seattle' do
      address = '400 Broad St'
      location = one_bus_away.get_location(address)

      expect(location).to eq([-122.3491348, 47.6205379])
    end
  end
end
