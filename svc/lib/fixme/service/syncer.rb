# frozen_string_literal: true

require 'sidekiq'
module Service
  class Syncer
    class << self
      RETRIES = 4

      def sync_user(userid)
        params = {
          'user_id': userid,
        }

        client.push(
          'queue' => 'nonexistingqueue',
          'retry' => RETRIES,
          'class' => 'Service::Sidekiq::Worker',
          'args' => ['sync', params.to_json, {}]
        )
      end

      private

      def client
        @_client ||= ::Sidekiq::Client.new(pool: pool)
      end

      def pool
        ::Sidekiq::RedisConnection.create(
          url: ENV['REDIS_URL']
        )
      end
    end
  end
end
