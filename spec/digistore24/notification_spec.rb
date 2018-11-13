# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Digistore24::Notification do
  let(:passphrase) { 'xxxxx' }
  let(:sha_sign) { File.read("#{RSPEC_ROOT}/fixtures/sha_sign.txt").strip }
  let(:params) do
    {
      buyer_email: 'claus@domain-xyz.de',
      order_id: '273732',
      payment_id: 'PAYID-39-22012',
      transaction_amount: '17.00',
      transaction_currency: 'USD',
      sha_sign: sha_sign
    }
  end

  let(:notification) { described_class.new(params) }

  before do
    Digistore24.configure do |config|
      config.passphrase = 'xxxxx'
    end
  end

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
      expect(notification.signature).to eq(sha_sign)
    end
  end

  describe '#valid?' do
    context 'when signatures are equal' do
      it 'returns true' do
        expect(notification.valid?).to eq(true)
      end
    end

    context 'when signatures are not equa' do
      before do
        params[:foo] = 'bar'
      end

      it 'returns false' do
        expect(notification.valid?).to eq(false)
      end
    end

    context 'when payload signature is not given' do
      let(:params) { {} }

      it 'returns false' do
        expect(notification.valid?).to eq(false)
      end
    end
  end

  describe '#to_h' do
    it 'returns the payload as hash' do
      expect(notification.to_h).to eq(params)
    end
  end

  describe '#validate!' do
    context 'when signature is valid' do
      it 'does not raise an error' do
        expect { notification.validate! }.not_to raise_error
      end
    end

    context 'when signature is not valid' do
      before do
        params[:foo] = 'bar'
      end

      it 'raises an error' do
        expect { notification.validate! }
          .to raise_error(Digistore24::NotificationError,
                          'Request signature invalid!')
      end
    end
  end
end
