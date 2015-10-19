require 'one_bus_away/client'

RSpec.describe OneBusAway::Client do
  let(:valid_client) do
    OneBusAway::Client.new(
      api_key: 'aer-dkjfwif0d-slkjsdflkjs',
      api_method: 'route-ids-for-agency',
      parameters: 'someparameters'
    )
  end

  let(:invalid_client) { OneBusAway::Client.new }

  describe '#api_method' do
    it 'to respond' do
      expect(valid_client).to respond_to(:api_method)
    end
    it 'returns api_method' do
      expect(valid_client.api_method).to eq('route-ids-for-agency')
    end
  end

  describe '#api_key' do
    it 'to respond' do
      expect(valid_client).to respond_to(:api_key)
    end
    it 'returns api_method' do
      expect(valid_client.api_key).to eq('aer-dkjfwif0d-slkjsdflkjs')
    end
  end

  describe '#parameters' do
    it 'to respond' do
      expect(valid_client).to respond_to(:parameters)
    end
    it 'returns parameters' do
      expect(valid_client.parameters).to eq('someparameters')
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
  end

  describe '#body' do
    it 'responds' do
      expect(invalid_client).to respond_to(:body)
    end

    it 'not nill when calling body' do
      obj = valid_client
      obj.get

      expect(obj.body).not_to be_nil
    end
  end

  describe '#build_url' do
    it 'responses' do
      expect(invalid_client).to respond_to(:build_url)
    end
  end

  describe '#base_url' do
    it 'equals the correct string' do
      expect(invalid_client.base_url).to eq('http://api.pugetsound.onebusaway.org/api/where/')
    end
  end

  describe '#apply_local_api_key' do
    it 'responds' do
      expect(invalid_client).to respond_to(:apply_local_api_key)
    end

    it 'fails if file does not exists' do
      allow(File).to receive(:exist?).and_return(false)

      expect{ invalid_client.apply_local_api_key }.to raise_error
    end
    it 'succeeds if file exists' do
      file_like_object = double("123-12321321-1234jsdkfjsd")
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(file_like_object)

      expect(invalid_client.apply_local_api_key).to eq(file_like_object)
    end
  end
end
