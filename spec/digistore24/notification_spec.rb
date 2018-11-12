# frozen_string_literal: true

RSpec.describe Digistore24::Notification do
  let(:passphrase) { 'xxxxx' }
  let(:params) do
    {
      buyer_email: 'claus@domain-xyz.de',
      order_id: '273732',
      payment_id: 'PAYID-39-22012',
      transaction_amount: '17.00',
      transaction_currency: 'USD',
      # TODO: Move to file fixture
      sha_sign: '342770076245D14ED7DF4D2E5D82216D7EDF8F9E7969B5964C9C5DCB53E962BBECD545E90422B5329C69554FD8B1A7E7410736615FCA7FB5CBB3624CC016E4BC'
    }
  end

  let(:notification) { described_class.new(params) }

  it 'initializes without raising any error' do
    expect { notification }.not_to raise_error
  end

  describe '#payload' do
    it 'returns an open struct' do
      expect(notification.payload).to be_a(RecursiveOpenStruct)
    end

    it 'contains all given params' do
      expect(notification.payload.to_h).to eq(params)
    end
  end

  describe '#signature' do
    it 'calculates the correct signature' do
      expect(notification.signature).to eq(notification.payload.sha_sign)
    end
  end
end
