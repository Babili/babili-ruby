RSpec.describe Babili::Platform::User, ".all" do
  context "when there are no users" do
    before(:each) do
      stub_request(:get, "https://babili-api.spin42.me/platform/users")
        .to_return(body: '{"data": [], "meta": { "count": 0 } }')
    end

    it "should return an empty array" do
      expect(Babili::Platform::User.all.size).to eq(0)
    end
  end

  context "when is a user" do
    before(:each) do
      stub_request(:get, "https://babili-api.spin42.me/platform/users")
        .to_return(body: '{"data": [{"type": "user", "data": {"id": 1234}}], "meta": { "count": 1 } }')
    end

    it "should not return an empty array" do
      expect(Babili::Platform::User.all.size).to eq(1)
    end
  end
end
