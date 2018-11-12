# frozen_string_literal: true

require 'digest'

module Digistore24
  # The main notification class which represents an Instant Payment
  # Notification (IPN).
  class Notification
    attr_reader :payload

    # Initialize the notification.
    #
    # @param params [Hash] The request parameters from Digistore24.
    # @return [Notification]
    def initialize(params)
      @payload = RecursiveOpenStruct.new(params)
    end

    # Calculate SHA512 signature for payload.
    #
    # @return [String] The signature.
    def signature
      # Remove 'sha_sign' key from request params and concatenate all
      # key value pairs
      params = @payload.to_h
        .reject { |key, value| key == :sha_sign }.sort
        .map { | key, value| "#{key}=#{value}#{passphrase}" }.join

      # Calculate SHA512 and upcase all letters, since Digistore will
      # also return upcased letters in the signature.
      Digest::SHA512.hexdigest(params).upcase
    end

    private

    def passphrase
      'xxxxx'
    end
  end
end
