# frozen_string_literal: true

RSpec.describe WaterDrop::Producer::DummyClient do
  subject(:client) { described_class.new }

  describe 'publishing interface' do
    it 'expect to return self for further chaining' do
      expect(client.publish_sync({})).to eq(client)
    end
  end

  describe '#wait' do
    it { expect(client.wait).to be_a(::Rdkafka::Producer::DeliveryReport) }

    context 'when we wait on many messages' do
      before { 10.times { client.wait } }

      it 'expect to bump the offset of the messages' do
        expect(client.wait.offset).to eq(10)
      end
    end
  end
end
