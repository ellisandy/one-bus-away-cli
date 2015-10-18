require 'one_bus_away/client'

RSpec.describe OneBusAway::Client do
  describe '.some_method' do
    it "returns true" do
      some_value = OneBusAway::Client.new
      expect(some_value.class).to be_empty
    end
  end
end
