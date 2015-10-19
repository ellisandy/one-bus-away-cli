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

end
