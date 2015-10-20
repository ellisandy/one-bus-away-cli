require 'one_bus_away'

RSpec.describe OneBusAway::Utilities do
  describe '.convert_time'

  describe '.strip_time' do
    it 'raises error when now parameters are provided' do
      expect { OneBusAway::Utilities.strip_time }.to raise_error
    end

    it 'does not raise an error' do
      obj = OneBusAway::Utilities.new

      expect { obj.strip_time('12345679') }.not_to raise_error
    end

    it 'returns four less characters' do
      string = '1234567890'
      obj = OneBusAway::Utilities.new

      expect(obj.strip_time(string).length).to eq(string.length - 3)
    end
  end

  describe 'distance_of_time_in_hours_and_minutes'
end
