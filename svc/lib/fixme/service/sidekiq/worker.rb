# frozen_string_literal: true

require 'sidekiq'

module Service
  module Sidekiq
    class Worker
      include ::Sidekiq::Job
      sidekiq_options queue: :service_sync

      def perform(event, payload, _options = {})
        payload = JSON.parse(payload)
        if payload.include?('user_id')
          if event == 'sync'
            ::User.find(payload['user_id'])&.update!(sync_status: "OK")
          end
        end

      end
    end
  end
end
