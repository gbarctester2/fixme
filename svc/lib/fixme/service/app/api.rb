# frozen_string_literal: true

require 'sinatra/base'
require 'active_record'

module Service
  class App
    class Api < Sinatra::Base

      def current_user
        uid = request.env['HTTP_X_USER_ID']
        User.find(uid) if uid
      end

      def protected_area
        unless authorized?
          throw(:halt, [401, 'not authorized'])
        end
      end

      def authorized?
        false
      end

      configure :development do
        set :host_authorization, { permitted_hosts: [] }
      end

      before { protected_area unless request.path_info == '/ping' }

      error NotImplementedError do
        content_type :json
        status 501
        { message: 'not implemented' }.to_json
      end

      error NoMethodError do
        content_type :json
        status 501
        { message: 'not implemented' }.to_json
      end

      not_found do
        status 404
        { message: 'not found' }.to_json
      end

      error JSON::ParserError do
        status 400
        { message: 'invalid JSON' }.to_json
      end

      configure do
        enable :raise_errors, :dump_errors
        set :show_exceptions, true
      end

      get '/ping' do
        status 200
        content_type :txt
        'pong'
      end


      post '/sync' do
        # handling is missing here
        status 404
        { message: 'not found' }.to_json
      end

      def syncer
        @_syncer ||= Service::Syncer
      end
    end
  end
end
