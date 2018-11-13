# frozen_string_literal: true

require 'digest'

module Digistore24
  # A basic NotificationError that implies that there is an error.
  class NotificationError < StandardError; end

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
      params = payload.to_h
        .reject { |key, value| key == :sha_sign }.sort
        .map { | key, value| "#{key}=#{value}#{passphrase}" }.join

      # Calculate SHA512 and upcase all letters, since Digistore will
      # also return upcased letters in the signature.
      Digest::SHA512.hexdigest(params).upcase
    end

    # Checks if the provided sha_sign is valid.
    #
    # @return [Booleand] The answer
    def valid?
      # If payload does not contain the sha_sign definitely return false.
      return false unless payload.sha_sign

      signature == payload.sha_sign
    end

    # Checks the request parameters signature and raises an error if it
    # does not equal to the calculated signature.
    #
    # @return [NilClass]
    # @raise [Digistore24::NotificationError]
    def validate!
      return if valid?
      raise NotificationError, 'Request signature invalid!'
    end

    private

    # Return the passphrase from the global configuration.
    #
    # @return [String] The passphrase
    def passphrase
      Digistore24.configuration.passphrase
    end
  end
end
