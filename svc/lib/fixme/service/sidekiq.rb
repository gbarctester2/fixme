# frozen_string_literal: true

require 'sidekiq'
require './config/setup'
require 'fixme/service'
require 'fixme/service/sidekiq/worker'
require 'active_support/core_ext/hash/keys'

module Service
  module Sidekiq
    def setup
      ::Sidekiq.configure_server do |c|
        c.redis = {
          url: ENV['REDIS_URL']
        }

        c.server_middleware do |chain|
        end
      end
    end
    extend self # rubocop:disable Style/ModuleFunction
  end
end
Service::Sidekiq.setup
