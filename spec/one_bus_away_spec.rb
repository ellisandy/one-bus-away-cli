require 'one_bus_away'

RSpec.describe OneBusAway do
  context "Testing" do
    it "runs initial test" do
      expect(OneBusAway).not_to eq(nil)
    end
  end
  
  context "api_key" do
    it "does not equal nil" do
      expect(OneBusAway.api_key).not_to eq(nil)
    end
    it "errors out when no file is found" do
      expect(OneBusAway.api_key).to eq(File.read(ENV['HOME']+"/.one_bus_away"))
    end
  end
  
  context 'get current time' do
    it 'returns the current time' do
      expect(OneBusAway.current_time.class).to eq(Fixnum)
    end
  end
end