RSpec.describe Spider::Fetcher do

  context "RabbitMQ Client " do
    before do
      @fetcher = Spider::Fetcher.new
    end

    it "only has one client without exchange_name " do
      client = @fetcher.mq_client
      expect(client).to be Spider::MqClient.instance
    end

    it "create a new client while having a exchange_name " do
      client = @fetcher.mq_client("rspec_name")
      expect(client).not_to eq(Spider::MqClient.instance)
      @fetcher.stop
    end
  end
end
