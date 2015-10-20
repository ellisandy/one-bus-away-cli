require 'one_bus_away'

RSpec.describe OneBusAway::Utilities do
  describe '.convert_time' do
    it { expect(OneBusAway::Utilities).to respond_to(:convert_time) }
    it 'returns the correct format' do
      expect(OneBusAway::Utilities.convert_time('1445318245161').to_s)
        .to eq('2015-10-19 22:17:25 -0700')
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
