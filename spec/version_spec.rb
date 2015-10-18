require 'one_bus_away/version'

RSpec.describe OneBusAway do
  context '#Version' do
    it 'has a version' do
      expect(OneBusAway::VERSION).to be_kind_of(String)
    end
  end
end
