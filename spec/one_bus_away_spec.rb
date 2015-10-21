require 'one_bus_away'

RSpec.describe OneBusAway do
  let(:one_bus_away) { OneBusAway.new }

  describe '.new' do
    it 'responds' do
      expect(OneBusAway).to respond_to(:new)
    end

    it 'has a accessor for input' do
      one_bus_away.input = 'some input'

      expect(one_bus_away.input).to eq('some input')
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
      expect { one_bus_away.client = '' }.to raise_error
    end

    it 'has a reader output' do
      expect(one_bus_away).to respond_to(:output)
    end

    it 'does not have a writer for output' do
      expect { one_bus_away.output = '' }.to raise_error
    end

  end

  describe '#current-time' do
    before(:each) { one_bus_away_client = nil }

    it 'responds' do
      expect(one_bus_away).to respond_to(:'current_time')
    end

    it 'creates @client' do
      allow_any_instance_of(OneBusAway::Client).to receive(:build_url).and_return(:true)

      one_bus_away.current_time
      expect(one_bus_away.client).to be_a(OneBusAway::Client)
    end
    it 'fails if .build_url doesnt validate' do
      allow_any_instance_of(OneBusAway::Client).to receive(:valid?).and_return(:false)
      one_bus_away_client = OneBusAway.new

      expect { one_bus_away_client.current_time }.to raise_error(RuntimeError, 'url not properly built')
    end
    # it 'calls .get'
    it 'fails if @url is not set' do
      allow_any_instance_of(OneBusAway::Client).to receive(:url).and_return(:false)
      one_bus_away_client = OneBusAway.new

      expect { one_bus_away_client.current_time }.not_to raise_error
    end
    # it 'sets @output'
  end
end
