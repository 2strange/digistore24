# frozen_string_literal: true

require 'recursive_open_struct'

require 'digistore24/version'
require 'digistore24/notification'

# The main module for all Digistore24 related models and methods.
module Digistore24
  class << self
    attr_writer :configuration

    # Returns the gem wide configuration.
    #
    # @return [RecursiveOpenStruct]
    def configuration
      @configuration ||= RecursiveOpenStruct.new
    end

    # Configure the gem wide configuration object.
    # There are currently no regulations on what to store inside this object
    # - any key is allowed.
    #
    # @example:
    #   Digistore24.configure do |config|
    #     config.passphrase = 'xxxxx'
    #   end
    def configure
      yield(configuration)
    end
  end
end
