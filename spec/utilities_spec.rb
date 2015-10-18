require 'one_bus_away'

RSpec.describe Utilities do
  describe '.convert_time'

  describe '.strip_time' do
    it 'raises error when now parameters are provided' do
      expect { Utilities.strip_time }.to raise_error
    end

    it 'does not raise an error' do
      expect { Utilities.strip_time('12345679') }.not_to raise_error
    end

    it 'returns four less characters' do
      string = '1234567890'

      expect(Utilities.strip_time(string).length).to eq(string.length - 3)
    end
  end

  describe 'distance_of_time_in_hours_and_minutes'
end
