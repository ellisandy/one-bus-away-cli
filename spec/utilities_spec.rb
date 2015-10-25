require 'one_bus_away'

RSpec.describe OneBusAway::Utilities do
  describe '.convert_time' do
    it { expect(OneBusAway::Utilities).to respond_to(:convert_time) }

    # Format from OBA API is Time as integer * 1000
    it 'returns the correct format' do
      time = (Time.now + 240).to_i * 1000

      expect(OneBusAway::Utilities.convert_time(time))
        .to eq('4 minutes')
    end
  end

  describe '#strip_time' do
    it { expect(OneBusAway::Utilities.new).to respond_to(:strip_time) }
    it 'removes the last for characters' do
      time = '1445318245161'
      obj = OneBusAway::Utilities.new

      expect(obj.strip_time(time)).to eq('1445318245')
    end
  end
end
