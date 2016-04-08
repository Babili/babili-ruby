RSpec.describe Babili::Platform::Room do
  describe "#all" do
    context "when there are no rooms" do
      before(:each) do
        stub_request(:get, "https://babili-api.spin42.me/platform/rooms")
          .to_return(body: '{"data": [], "meta": { "count": 0 } }')
      end

      it "should return an empty array" do
        expect(Babili::Platform::Room.all.size).to eq(0)
      end
    end

    context "when there is a Room" do
      before(:each) do
        stub_request(:get, "https://babili-api.spin42.me/platform/rooms")
          .to_return(body: '{"data": [{"type": "room", "data": {"id": 1234}}], "meta": { "count": 1 } }')
      end

      it "should not return an empty array" do
        expect(Babili::Platform::Room.all.size).to eq(1)
      end
    end
  end
end
