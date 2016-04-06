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
end
