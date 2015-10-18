require 'one_bus_away'

RSpec.describe OneBusAway do
  describe '.new' do
    it 'should raise error without arguements' do
      expect { OneBusAway.new }.to raise_error
    end

    it 'should accept API_KEY as arguement' do
      expect { OneBusAway.new('somestring') }.not_to raise_error
    end
  end

  describe '#current_time' do
    let(:one_bus_away) do
      OneBusAway.new('6a1c72f7-6ec4-4522-bf33-3698b3ad86c2')
    end
    it 'to not raise an error' do
      expect { one_bus_away.current_time }.not_to raise_error
    end
  end

  describe '#arrivals_and_departures_for_stop' do
    let(:one_bus_away) do
      OneBusAway.new('6a1c72f7-6ec4-4522-bf33-3698b3ad86c2')
    end
    it 'returns true' do
      expect do
        one_bus_away.arrivals_and_departures_for_stop('18145', 40, 10)
      end.not_to raise_error
    end
  end

  describe '#valid_stop?' do
    let(:one_bus_away) do
      OneBusAway.new('6a1c72f7-6ec4-4522-bf33-3698b3ad86c2')
    end
    it 'returns true' do
      expect { one_bus_away.valid_stop?('18145') }.not_to raise_error
    end
  end
end
