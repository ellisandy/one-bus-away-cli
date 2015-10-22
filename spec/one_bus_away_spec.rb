require 'one_bus_away'

RSpec.describe OneBusAway do
  describe '#get_location' do
    it { expect(OneBusAway.new).to respond_to(:get_location) }
    it 'returns the latitude and longitude of a given address in Seattle' do
      loc = "400 Broad St"
      obj=OneBusAway.new

      lat,lon=obj.get_location(loc)

      expect(lat).to eq(47.620537)
      expect(lon).to eq(-122.3491348)
    end
  end
end
