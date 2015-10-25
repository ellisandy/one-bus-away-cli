require 'one_bus_away/client'

RSpec.describe OneBusAway::Client do
  let(:valid_client) do
    OneBusAway::Client.new(
      api_method: ['current-time']
    )
  end

  let(:invalid_client) { OneBusAway::Client.new }

  describe '#api_key' do
    it 'to respond' do
      expect(valid_client).to respond_to(:api_key)
    end
    it 'returns api_key' do
      client = valid_client
      client.api_key = 'aer-dkjfwif0d-slkjsdflkjs'
      expect(client.api_key).to eq('aer-dkjfwif0d-slkjsdflkjs')
    end

    it 'calls apply_local_api_key' do
      file_like_object = 'somekey'
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(file_like_object)

      expect(invalid_client.api_key).to eq('somekey')
    end
  end

  describe '#apply_local_api_key' do
    it 'responds' do
      expect(invalid_client).to respond_to(:apply_local_api_key)
    end

    it 'fails if file does not exists' do
      allow(File).to receive(:exist?).and_return(false)

      expect { invalid_client.apply_local_api_key }
        .to raise_error(RuntimeError, 'no API key provided. '\
                        'Please ensure you have your api key'\
                        'installed in here: ~/.one_bus_away'
                       )
    end
    it 'succeeds if file exists' do
      file_like_object = '123-12321321-1234jsdkfjsd'
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(file_like_object)

      expect(invalid_client.apply_local_api_key).to eq(file_like_object)
    end
  end

  describe '#api_method' do
    it 'to respond' do
      expect(valid_client).to respond_to(:api_method)
    end
    it 'returns api_method' do
      client = valid_client
      client.api_method = ['route-ids-for-agency']
      expect(client.api_method).to eq(['route-ids-for-agency'])
    end
  end

  describe '#build_path' do
    it 'responds' do
      expect(invalid_client).to respond_to(:build_path)
    end
    it 'formats correctly' do
      client = valid_client
      client.api_method = ['route-ids-for-agency', '1']

      expect(client.build_path)
        .to eq('/api/where/route-ids-for-agency/1.json')
    end
  end

  describe '#parameters' do
    it 'to respond' do
      expect(valid_client).to respond_to(:parameters)
    end
    it 'returns parameters' do
      client = valid_client
      client.parameters = { somekey: 'someparameters' }

      expect(valid_client.parameters)
        .to eq(somekey: 'someparameters')
    end
  end

  describe '#build_query' do
    it 'responds' do
      expect(invalid_client).to respond_to(:build_query)
    end

    it 'contains api_key if no parameters' do
      client = valid_client
      client.parameters = nil
      client.api_key = 'thisissomekeyyyyy'

      expect(client.build_query).to eq('key=thisissomekeyyyyy')
    end
    it 'contains all parameters if included' do
      client = valid_client
      client.api_key = 'thisissomekeyyyyy'
      client.parameters = {
        route: 'someroute',
        stop: 'somestop'
      }

      expect(client.build_query)
        .to eq('key=thisissomekeyyyyy&route=someroute&stop=somestop')
    end
  end

  describe '.valid?' do
    context 'with valid paremeters' do
      it 'is truthy' do
        expect(valid_client.valid?).to be_truthy
      end
    end

    context 'without valid parameters' do
      it 'is falsey' do
        expect(invalid_client.valid?).to be_falsey
      end
    end
  end

  describe '#get' do
    it 'responds' do
      expect(invalid_client).to respond_to(:get)
    end
    it 'fails if url not built' do
      client = invalid_client

      expect { client.get }
        .to raise_error(RuntimeError, 'url is not properly built')
    end
  end

  describe '#base_url' do
    it 'equals the correct string' do
      expect(invalid_client.base_url)
        .to eq('api.pugetsound.onebusaway.org')
    end
  end

  describe '#build_url' do
    it { expect(invalid_client).to respond_to(:build_url) }

    it 'returns correct url without parameters' do
      client = valid_client
      client.api_key = 'somekey'
      client.parameters = nil
      client.api_method = ['current_time']

      expect(valid_client.build_url)
        .to eq('http://api.pugetsound.onebusaway.org/api/where/current_time.json?key=somekey')
    end

    it 'returns correct url without parameters' do
      client = valid_client
      client.api_key = 'somekey'
      client.parameters = { route: '123532' }
      client.api_method = ['arrivals-and-departures-for-stop', '1_75403']

      expect(valid_client.build_url)
        .to eq('http://api.pugetsound.onebusaway.org'\
        '/api/where/arrivals-and-departures-for-stop/'\
        '1_75403.json?key=somekey&route=123532'
              )
    end

    it 'calls valid?' do
      expect(valid_client).to receive(:valid?)
      valid_client.build_url
    end

    it 'returns false with valid? false' do
      client = invalid_client
      client.build_url

      expect(client.url).to be_nil
    end
  end

  describe '#url' do
    it { expect(invalid_client).to respond_to(:url) }
    it 'is set when calling build_url' do
      client = valid_client
      client.build_url

      expect(client.url).not_to be_nil
    end
  end

  describe '#http_response' do
    it { expect(invalid_client).to respond_to(:http_response) }
    it 'is set when calling #build_url' do
      VCR.use_cassette('one_bus_away/current-time') do
        client = valid_client
        client.build_url
        client.get

        expect(client.http_response).not_to be_nil
      end
    end
  end
end
